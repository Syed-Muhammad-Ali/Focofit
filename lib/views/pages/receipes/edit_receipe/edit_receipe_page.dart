import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class EditReceipePage extends StatefulWidget {
  const EditReceipePage({super.key});

  @override
  State<EditReceipePage> createState() => _EditReceipePageState();
}

class _EditReceipePageState extends State<EditReceipePage> {
  final recipeNameCtr = TextEditingController();
  final sugarCtr = TextEditingController();
  final cocoaCtr = TextEditingController();
  final milkCtr = TextEditingController();
  final flourCtr = TextEditingController();
  final cinnamonCtr = TextEditingController();
  final preparationCtr = TextEditingController();

  String? selectedSugar;
  String? selectedCocoa;
  String? selectedMilk;
  String? selectedFlour;
  String? selectedCinnamon;

  final List<String> _units = [
    'colher(es) de sobremesa',
    'teaspoon(s)',
    'tablespoon(s)',
    'gram(s)',
    'millilitre(s)',
    'cup(s) of tea',
    'cup(s) of coffee',
  ];
  int _currentScrollIndex = 0;

  bool get _isFormValid {
    return recipeNameCtr.text.isNotEmpty &&
        preparationCtr.text.isNotEmpty &&
        sugarCtr.text.isNotEmpty &&
        cocoaCtr.text.isNotEmpty &&
        milkCtr.text.isNotEmpty &&
        flourCtr.text.isNotEmpty &&
        cinnamonCtr.text.isNotEmpty &&
        selectedSugar != null &&
        selectedCocoa != null &&
        selectedMilk != null &&
        selectedFlour != null &&
        selectedCinnamon != null;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
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
                      'Edit recipe',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/Back.png',
                    height: 39,
                    width: 39,
                    color: Colors.transparent,
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
                    AppTextfield(
                      ctr: recipeNameCtr,
                      hint:
                          'Creamy avocado pudding without sugar and sour cream',
                      onchanged: (_) => setState(() {}),
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: AppText(
                            "Ingrediente",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.textColor,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: AppText(
                            "Qntd.",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.textColor,
                          ),
                        ),
                        SvgPicture.asset("assets/icons/info.svg"),
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    IngredientRow(
                      ingredientHint: "Crystal sugar",
                      ctr: sugarCtr,
                      selectedValue: selectedSugar,
                      onTapRightField: () async {
                        final result = await _showUnitBottomSheet();
                        if (result != null) {
                          setState(() => selectedSugar = result);
                        }
                      },
                    ),
                    IngredientRow(
                      ingredientHint: "Cocoa powder",
                      ctr: cocoaCtr,
                      selectedValue: selectedCocoa,
                      onTapRightField: () async {
                        final result = await _showUnitBottomSheet();
                        if (result != null) {
                          setState(() => selectedCocoa = result);
                        }
                      },
                    ),
                    IngredientRow(
                      ingredientHint: "Cow's milk",
                      ctr: milkCtr,
                      selectedValue: selectedMilk,
                      onTapRightField: () async {
                        final result = await _showUnitBottomSheet();
                        if (result != null) {
                          setState(() => selectedMilk = result);
                        }
                      },
                    ),
                    IngredientRow(
                      ingredientHint: "Wheat flour",
                      ctr: flourCtr,
                      selectedValue: selectedFlour,
                      onTapRightField: () async {
                        final result = await _showUnitBottomSheet();
                        if (result != null) {
                          setState(() => selectedFlour = result);
                        }
                      },
                    ),
                    IngredientRow(
                      ingredientHint: "Cinnamon powder",
                      ctr: cinnamonCtr,
                      selectedValue: selectedCinnamon,
                      onTapRightField: () async {
                        final result = await _showUnitBottomSheet();
                        if (result != null) {
                          setState(() => selectedCinnamon = result);
                        }
                      },
                    ),
                    SizedBox(height: height * 0.05),
                    SizedBox(
                      width: width,
                      child: AppButton(
                        bgColor: Colors.white,
                        borderColor: AppColor.textColor,
                        useborder: true,
                        txtClr: AppColor.textColor,
                        ontap: () {},
                        label: 'Add ingredient',
                        isElevation: false,
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    AppTextfield(
                      ctr: preparationCtr,
                      title: 'Preparation mode',
                      hint:
                          'Mix everything and cook over medium heat for 15 minutes, continuing to stir.',
                      maximumLines: 5,
                      minimumLines: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          SizedBox(
            width: width,
            child: AppButton(
              label: 'Save changes',
              weight: FontWeight.w500,
              ontap:
                  _isFormValid
                      ? () {
                        print("Form is valid, saving data...");
                      }
                      : null,
              bgColor:
                  _isFormValid
                      ? AppColor.primaryColor
                      : const Color(0xffD2D2D2),
            ),
          ),
          SizedBox(height: height * 0.03),
        ],
      ),
    );
  }

  // ✅ Bottom sheet with wheel picker
  Future<String?> _showUnitBottomSheet() async {
    return await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Drag handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),

                  AppText(
                    'Select the measurement',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 16),

                  Divider(height: 1, color: Colors.grey[300]),
                  const SizedBox(height: 20),

                  // ✅ Wheel Picker
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 50,
                      diameterRatio: 1.5,
                      perspective: 0.01,
                      physics: const FixedExtentScrollPhysics(),
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
                        setModalState(() {
                          _currentScrollIndex = index;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  AppButton(
                    label: 'Confirm',
                    ontap: () {
                      Navigator.pop(context, _units[_currentScrollIndex]);
                    },
                    bgColor: AppColor.primaryColor,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ✅ IngredientRow widget
class IngredientRow extends StatelessWidget {
  final String ingredientHint;
  final TextEditingController ctr;
  final String? selectedValue;
  final VoidCallback onTapRightField;

  const IngredientRow({
    super.key,
    required this.ingredientHint,
    required this.ctr,
    required this.selectedValue,
    required this.onTapRightField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: AppTextfield(ctr: ctr, hint: ingredientHint),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: onTapRightField,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.greyColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AppText(
                        selectedValue ?? "g",
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
    );
  }
}
