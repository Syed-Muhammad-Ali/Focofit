import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class LogoutBottomSheet extends GetxController {
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
            child: GetBuilder<LogoutBottomSheet>(
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
                        'Log out of account',
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
                              'Are you sure you want to log out of your account?',
                              textAlign: TextAlign.center,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textColor,
                            ),
                            SizedBox(height: Get.height * 0.02),
                            AppText(
                              'You can log in again later if you wish.',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textColor,
                            ),
                            SizedBox(height: Get.height * 0.03),
                            AppButton(
                              label: 'I want to go back',
                              bgColor: AppColor.primaryColor,
                            ),
                            SizedBox(height: Get.height * 0.01),
                            AppButton(
                              label: 'Log out of account',
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
