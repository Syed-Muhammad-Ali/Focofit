import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/receipes/edit_receipe/edit_receipe_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/diary_container_tile.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class RevenuesDetailsPage extends StatefulWidget {
  const RevenuesDetailsPage({super.key});

  @override
  State<RevenuesDetailsPage> createState() => _RevenuesDetailsPageState();
}

class _RevenuesDetailsPageState extends State<RevenuesDetailsPage> {
  String? _imageUrl;
  bool _isReportValid = false;
  final _reportController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reportController.addListener(_checkReportValidity);
  }

  void _checkReportValidity() {
    setState(() {
      _isReportValid = _reportController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
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
                    Container(height: 1, color: Colors.grey[300]),
                    SizedBox(height: 20),
                    AppTextfield(
                      ctr: _reportController,
                      hint:
                          'Please describe the error in as much detail as possible so that we can resolve it as quickly and effectively as possible.',
                      maximumLines: 5,
                      minimumLines: 5,
                      onchanged: (value) {
                        setModalState(() {
                          _isReportValid = value.trim().isNotEmpty;
                        });
                      },
                    ),

                    // Report text field
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

  void _showMeasurementBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Drag Handle
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
                const SizedBox(height: 20),

                /// Title
                Center(
                  child: AppText(
                    'Measurement guide',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Container(height: 1, color: Colors.grey[300]),
                const SizedBox(height: 20),

                /// Table Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      'Measure',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textColor,
                    ),
                    AppText(
                      'Equivalents',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textColor,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(height: 1, color: Colors.grey[300]),
                const SizedBox(height: 10),
                _buildRow("colher de sobremesa (csb)", "7 g", "10 ml"),
                _buildRow("colher de chá (cch)", "3 g", "5 ml"),
                _buildRow("colher de sopa (csp)", "10 g", "15 ml"),
                _buildRow("pitada (pta)", "0,5 g", "-"),
                _buildRow("copo (cpo)", "125 g", "200 ml"),
                _buildRow("xícara de chá (xch)", "150 g", "240 ml"),
                _buildRow(
                  "xícara de café (xcf)",
                  "60 g",
                  "100 ml",
                  isLast: true,
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: 'To close',
                    ontap: () {
                      Navigator.pop(context);
                    },
                    bgColor: AppColor.primaryColor,
                    radius: 100,
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          HeaderContainer(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 40, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      'assets/icons/Back.png',
                      height: 39,
                      width: 39,
                    ),
                  ),
                  Center(
                    child: AppText(
                      'Revenues',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => EditReceipePage());
                    },
                    child: Image.asset(
                      'assets/icons/edit.png',
                      height: 39,
                      width: 39,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20),
                      child: Stack(
                        children: [
                          _imageUrl != null
                              ? Image.network(
                                _imageUrl!,
                                height: 290,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildPlaceholder();
                                },
                              )
                              : _buildPlaceholder(),
                          // Image.network(
                          //   'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500',
                          //   height: 290,
                          //   width: double.infinity,
                          //   fit: BoxFit.cover,
                          // ),
                          Positioned(
                            left: 8,
                            bottom: 8,
                            child: Row(
                              children: [
                                _tag("10 min"),
                                SizedBox(width: 14),
                                _tag('319 kcal'),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: Image.asset(
                              'assets/icons/favorites.png',
                              height: 43,
                              width: 43,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    AppText(
                      "Smoked salmon with lemon sauce and chestnut sauce",
                      maxLines: 2,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textColor,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    _buildCard(
                      iconPath: 'assets/icons/macros.png',
                      title: "Macronutrients",
                      child: Column(
                        children: [
                          const Divider(color: AppColor.dividerColor),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                _MacroItem(label: "Carboidrato", value: "300g"),
                                _MacroItem(label: "Proteína", value: "70g"),
                                _MacroItem(label: "Gordura", value: "130g"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      iconPath: 'assets/icons/ingredientes.png',
                      title: "Ingredients",
                      action: IconButton(
                        onPressed: () => _showMeasurementBottomSheet(),
                        icon: Icon(Icons.info, color: AppColor.primaryColor),
                      ),
                      child: Column(
                        children: [
                          const Divider(),
                          const _IngredientRow(
                            name: "Lorem ipsum",
                            quantity: "100g",
                          ),
                          const _IngredientRow(
                            name: "Lorem ipsum",
                            quantity: "100ml",
                          ),
                          const _IngredientRow(
                            name: "Lorem ipsum",
                            quantity: "100ml",
                          ),
                          const _IngredientRow(
                            name: "Lorem ipsum",
                            quantity: "100ml",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      iconPath: 'assets/icons/modo.png',
                      title: "Preparation mode",
                      child: Column(
                        children: [
                          const Divider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              _StepItem(
                                number: 1,
                                text: "Mix all ingredients in a bowl",
                              ),
                              _StepItem(
                                number: 2,
                                text: "Blend everything in a blender",
                              ),
                              _StepItem(
                                number: 3,
                                text: "Place in the oven and wait 40 minutes",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/alert.png'),
                        SizedBox(width: 8),
                        AppText(
                          'Did you find any errors? ',
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            _showReportBottomSheet();
                          },
                          child: AppText(
                            "Report",
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: AppText(
        text,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColor.textColor,
      ),
    );
  }

  Widget _buildCard({
    required String iconPath,
    required String title,
    Widget? action,
    required Widget child,
  }) {
    return DiaryContainerTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(iconPath, height: 20, width: 20, fit: BoxFit.contain),
              const SizedBox(width: 8),
              Expanded(
                child: AppText(
                  title,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textColor,
                ),
              ),
              if (action != null) action,
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _imageUrl =
              "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500";
        });
      },

      child: Container(
        height: 290,
        width: double.infinity,
        color: AppColor.greyColor.withOpacity(.10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/upload.svg"),
            SizedBox(height: 8),
            AppText(
              "Tap to add a photo",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.greyColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String medida, String g, String ml, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: AppText(
                  medida,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColor.textColor,
                ),
              ),
              Expanded(
                flex: 1,
                child: AppText(
                  g,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textColor,
                ),
              ),
              Expanded(
                flex: 1,
                child: AppText(
                  ml,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textColor,
                ),
              ),
            ],
          ),
        ),
        if (!isLast) Container(height: 1, color: Colors.grey[300]),
      ],
    );
  }
}

class _MacroItem extends StatelessWidget {
  final String label;
  final String value;

  const _MacroItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          label,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColor.textColor,
        ),
        const SizedBox(height: 4),
        AppText(
          value,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColor.textColor,
        ),
      ],
    );
  }
}

class _IngredientRow extends StatelessWidget {
  final String name;
  final String quantity;

  const _IngredientRow({required this.name, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              name,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.textColor,
            ),
          ),
          Expanded(
            child: Divider(color: AppColor.dividerColor, thickness: 0.8),
          ),
          const SizedBox(width: 8),
          AppText(
            quantity,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColor.textColor,
          ),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final int number;
  final String text;

  const _StepItem({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$number.", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 6),
          Expanded(
            child: AppText(
              text,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
