import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class ChangeLanguageBottomSheet extends GetxController {
  final newname = TextEditingController();
  final cname = TextEditingController();

  void showLogMealBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: GetBuilder<ChangeLanguageBottomSheet>(
              init: this,
              builder:
                  (controller) => Column(
                    children: [
                      // Handle bar
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 12),
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
                      AppText(
                        'Change Email',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: const Divider(),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      // Text fields
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            AppText(
                              'Change application language',

                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColor.textColor,
                            ),
                            SizedBox(height: Get.height * 0.02),
                            AppText(
                              'Do you really want to change the language?',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColor.textColor,
                            ),
                            SizedBox(height: Get.height * 0.03),
                            AppButton(
                              label: 'Cancel',
                              bgColor: AppColor.primaryColor,
                            ),
                            SizedBox(height: Get.height * 0.01),
                            AppButton(
                              label: 'Save',
                              txtClr: AppColor.textColor,
                              borderColor: AppColor.blackColor,
                              bgColor: AppColor.whiteColor,
                            ),
                          ],
                        ),
                      ),

                      Spacer(),
                    ],
                  ),
            ),
          ),
    );
  }
}
