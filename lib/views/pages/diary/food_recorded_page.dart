import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/bnb/bnb_page.dart';
import 'package:focofit/views/pages/diary/result_correction_page.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:get/get.dart';
import 'package:wheel_picker/wheel_picker.dart';

class FoodRecordedPage extends StatefulWidget {
  const FoodRecordedPage({super.key});

  @override
  State<FoodRecordedPage> createState() => _FoodRecordedPageState();
}

class _FoodRecordedPageState extends State<FoodRecordedPage> {
  bool isFav = false;
  final TextEditingController _servingSizeController = TextEditingController(
    text: '200',
  );
  final TextEditingController _reportController = TextEditingController();
  final TextEditingController _newNameController = TextEditingController();
  String _selectedUnit = 'gram(s)';
  int _currentScrollIndex = 3; // gram(s) is at index 3
  bool _isServingSizeChanged = false;
  bool _isReportValid = false;
  bool _isNewNameValid = false;
  String _currentFoodName = 'Decaffeinated espresso coffee without sugar';

  final List<String> _units = [
    'colher(es) de sobremesa',
    'teaspoon(s)',
    'tablespoon(s)',
    'gram(s)',
    'millilitre(s)',
    'cup(s) of tea',
    'cup(s) of coffee',
  ];

  @override
  void initState() {
    super.initState();
    _servingSizeController.addListener(_checkServingSizeChange);
    _reportController.addListener(_checkReportValidity);
    _newNameController.addListener(_checkNewNameValidity);
  }

  void _checkServingSizeChange() {
    setState(() {
      _isServingSizeChanged = _servingSizeController.text != '200';
    });
  }

  void _checkReportValidity() {
    setState(() {
      _isReportValid = _reportController.text.trim().isNotEmpty;
    });
  }

  void _checkNewNameValidity() {
    setState(() {
      _isNewNameValid = _newNameController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _servingSizeController.dispose();
    _reportController.dispose();
    _newNameController.dispose();
    super.dispose();
  }

  void _showUnitBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 20),

                // Title
                AppText(
                  'Select the measurement',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                SizedBox(height: 16),

                // Separator line
                Container(height: 1, color: Colors.grey[300]),
                SizedBox(height: 20),

                // Scrollable measurement picker
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    diameterRatio: 1.5,
                    perspective: 0.01,
                    physics: FixedExtentScrollPhysics(),
                    controller: FixedExtentScrollController(
                      initialItem: _currentScrollIndex,
                    ),
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        final unit = _units[index];
                        final isCurrentlySelected =
                            index == _currentScrollIndex;

                        return Center(
                          child: AppText(
                            unit,
                            fontSize: 16,
                            fontWeight:
                                isCurrentlySelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                isCurrentlySelected
                                    ? AppColor.primaryColor
                                    : Colors.grey[700],
                          ),
                        );
                      },
                      childCount: _units.length,
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _currentScrollIndex = index;
                      });
                    },
                  ),
                ),

                SizedBox(height: 20),

                // Confirm button
                AppButton(
                  label: 'Confirm',
                  ontap: () {
                    setState(() {
                      _selectedUnit = _units[_currentScrollIndex];
                    });
                    Navigator.pop(context);
                  },
                  bgColor: AppColor.primaryColor,
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
    );
  }

  void _showDeleteBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 20),

                // Title
                AppText(
                  'Delete record',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                SizedBox(height: 16),

                // Separator line
                Container(height: 1, color: Colors.grey[300]),
                SizedBox(height: 20),

                // Confirmation message
                AppText(
                  'Do you really want to remove this food from your records?',
                  fontSize: 16,
                  color: Colors.grey[600],
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 30),

                // Back button
                AppButton(
                  label: 'Back',
                  ontap: () {
                    Navigator.pop(context);
                  },
                  bgColor: AppColor.primaryColor,
                ),

                SizedBox(height: 12),

                // Delete button
                AppButton(
                  label: 'Delete',
                  txtClr: Colors.black,
                  ontap: () {
                    Get.off(() => BnbPage());
                  },
                  bgColor: Colors.white,
                  borderColor: Colors.black,
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
    );
  }

  void _showReportBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Handle bar
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Title
                    AppText(
                      'Report an error',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    SizedBox(height: 16),

                    // Separator line
                    Container(height: 1, color: Colors.grey[300]),
                    SizedBox(height: 20),

                    // Report text field
                    TextField(
                      controller: _reportController,
                      maxLines: 4,
                      onChanged: (value) {
                        setModalState(() {
                          _isReportValid = value.trim().isNotEmpty;
                        });
                      },
                      decoration: InputDecoration(
                        hintText:
                            'Please describe the error in as much detail as possible so that we can resolve it as quickly and effectively as possible.',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColor.primaryColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Send button
                    AppButton(
                      label: 'Send',
                      ontap:
                          _isReportValid
                              ? () {
                                Navigator.pop(context);
                                _showSuccessBottomSheet();
                              }
                              : null,
                      bgColor:
                          _isReportValid
                              ? AppColor.primaryColor
                              : Colors.grey[300],
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
    );
  }

  void _showSuccessBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 20),

                // Title
                AppText(
                  'Report an error',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                SizedBox(height: 16),

                // Separator line
                Container(height: 1, color: Colors.grey[300]),
                SizedBox(height: 20),

                // Success icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 40),
                ),

                SizedBox(height: 20),

                // Success message
                AppText(
                  'The error has been reported successfully, and our team will analyse the issue to correct it as quickly as possible.',
                  fontSize: 16,
                  color: Colors.grey[700],
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 30),

                // Confirm button
                AppButton(
                  label: 'Confirm',
                  ontap: () {
                    Navigator.pop(context);
                    _reportController.clear();
                    _checkReportValidity();
                  },
                  bgColor: AppColor.primaryColor,
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderContainer(
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Image.asset('assets/icons/Back.png'),
                ),
                title: AppText(
                  'Food recorded',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      _showDeleteBottomSheet();
                    },
                    icon: Image.asset('assets/icons/delete.png'),
                  ),
                ],
              ),
            ),
            // Food card
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200]!,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Food name with heart icon
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _showChangeNameBottomSheet();
                                },
                                child: AppText(
                                  _currentFoodName,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFav = !isFav;
                                });
                              },
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : Colors.grey[600],
                                size: 20,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        // Nutritional information
                        Row(
                          children: [
                            Expanded(
                              child: _buildNutritionColumn(
                                'Calories',
                                '319',
                                isHighlighted: true,
                              ),
                            ),
                            Expanded(
                              child: _buildNutritionColumn(
                                'Carbohydrate',
                                '300g',
                              ),
                            ),
                            Expanded(
                              child: _buildNutritionColumn('Protein', '100g'),
                            ),
                            Expanded(
                              child: _buildNutritionColumn('Fat', '35g'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // Serving size section
                  AppText(
                    'Serving size',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  SizedBox(height: 12),

                  Row(
                    children: [
                      // Serving size input
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _servingSizeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '100',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColor.primaryColor,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 12),

                      // Unit dropdown
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: _showUnitBottomSheet,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: AppText(
                                    _selectedUnit,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey[600],
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Is it incorrect? text
            Spacer(),

            // Report error section
            if (_isServingSizeChanged)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/alert.png'),
                    SizedBox(width: 8),
                    AppText(
                      'Is it incorrect? ',
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ResultCorrectionPage());
                      },
                      child: AppText(
                        'Correct result',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            _isServingSizeChanged
                ? SizedBox()
                : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/alert.png'),
                      SizedBox(width: 8),
                      AppText(
                        'Found an error? ',
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      GestureDetector(
                        onTap: () {
                          _showReportBottomSheet();
                        },
                        child: AppText(
                          'Report',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

            SizedBox(height: 20),

            // Save button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppButton(
                label: 'Save and go back',
                ontap: () {
                  // TODO: Save functionality
                  Get.off(() => BnbPage());
                },
                bgColor: AppColor.primaryColor,
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionColumn(
    String label,
    String value, {
    bool isHighlighted = false,
  }) {
    return Column(
      children: [
        AppText(label, fontSize: 12, color: Colors.grey[600]),
        SizedBox(height: 4),
        AppText(
          value,
          fontSize: isHighlighted ? 20 : 16,
          fontWeight: FontWeight.bold,
          color: isHighlighted ? AppColor.primaryColor : Colors.black,
        ),
      ],
    );
  }

  void _showChangeNameBottomSheet() {
    _newNameController.clear();
    _checkNewNameValidity();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Title
                    Center(
                      child: AppText(
                        'Change name',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey[300], height: 1),
                    SizedBox(height: 20),

                    // Current name field
                    AppText(
                      'Current name',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      enabled: false,
                      controller: TextEditingController(text: _currentFoodName),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // New name field
                    AppText(
                      'New name',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _newNameController,
                      onChanged: (value) {
                        setModalState(() {
                          _isNewNameValid = value.trim().isNotEmpty;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Example: Ham sandwich',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColor.primaryColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Confirm button
                    AppButton(
                      label: 'Confirm',
                      ontap:
                          _isNewNameValid
                              ? () {
                                setState(() {
                                  _currentFoodName =
                                      _newNameController.text.trim();
                                });
                                Navigator.pop(context);
                              }
                              : null,
                      bgColor:
                          _isNewNameValid
                              ? AppColor.primaryColor
                              : Colors.grey[300],
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
    );
  }
}
