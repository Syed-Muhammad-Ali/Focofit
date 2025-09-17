import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focofit/views/pages/adding_excercises/describe_exercise/register_exercise_screen.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../widgets/analyzing_food.dart' show AnalyzingFoodPage;
import '../../../widgets/text.dart';

class ResultCorrectionRegisterMealPage extends StatefulWidget {
  ResultCorrectionRegisterMealPage({super.key});

  @override
  State<ResultCorrectionRegisterMealPage> createState() =>
      ResultCorrectionRegisterMealPageState();
}

class ResultCorrectionRegisterMealPageState
    extends State<ResultCorrectionRegisterMealPage> {
  final desc = TextEditingController();
  // ignore: unused_field
  bool _isFormValid = false;
  void initState() {
    super.initState();

    desc.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    setState(() {
      _isFormValid = desc.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Column(
        children: [
          HeaderContainer(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 40, right: 16.0),
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
                      'Result correction',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/Add.svg',
                    height: 39,
                    width: 39,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                AppTextfield(
                  ctr: desc,
                  hint:
                      'Example: 35 minutes of high-intensity leg strength training',
                  titleSize: 16,
                  titleColor: AppColor.textColor,
                  maximumLines: 6,
                  minimumLines: 6,
                ),
                const Spacer(),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/info_vector.svg'),
                    SizedBox(width: Get.width * 0.04),
                    Flexible(
                      child: AppText(
                        textOverflow: TextOverflow.clip,
                        'Example: The tomato sauce and green olives are missing.',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.greyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),

                AppButton(
                  label: 'To analyze',
                  bgColor:
                      _isFormValid ? AppColor.primaryColor : Colors.grey[300],
                  ontap:
                      _isFormValid
                          ? () {
                            Get.to(
                              () => AnalyzingFoodPage(
                                title: 'Result correction',
                                onComplete: () {
                                  Get.to(() => RegisterExerciseScreen());
                                },
                              ),
                            );
                            // Handle valid form submit here
                            print("Form is valid, analyzing...");
                          }
                          : null, // disables button when form invalid
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ).paddingSymmetric(horizontal: 20),
          ),
        ],
      ),
    );
  }
}


///Describe exercise