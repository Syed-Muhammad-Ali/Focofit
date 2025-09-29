import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class ChangePasswordBottomSheet extends GetxController {
  final opass = TextEditingController();
  final npass = TextEditingController();

  final cpass = TextEditingController();
  RxString current = 'pass'.obs;
  void showLogMealBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GetBuilder<ChangePasswordBottomSheet>(
          init: this,
          builder: (controller) {
            // ✅ Dynamic height based on current.value
            double sheetHeight =
                controller.current.value == 'pass'
                    ? MediaQuery.of(context).size.height * 0.5
                    : MediaQuery.of(context).size.height * 0.4;

            return Container(
              height: sheetHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // Handle bar
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  const AppText(
                    'Change password',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  SizedBox(height: Get.height * 0.01),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(),
                  ),
                  SizedBox(height: Get.height * 0.02),

                  // 🔥 Content based on step
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        controller.current.value == 'pass'
                            ? Column(
                              children: [
                                AppTextfield(
                                  title: 'Old Password',
                                  titleSize: 16,
                                  titleColor: AppColor.textColor,
                                  ctr: opass,
                                  onchanged: (_) => update(),
                                ),
                                AppTextfield(
                                  title: 'New Password',
                                  titleSize: 16,
                                  titleColor: AppColor.textColor,
                                  ctr: npass,
                                  onchanged: (_) => update(),
                                ),
                                AppTextfield(
                                  title: 'Confirm Password',
                                  titleSize: 16,
                                  titleColor: AppColor.textColor,
                                  ctr: cpass,
                                  onchanged: (_) => update(),
                                ),
                                SizedBox(height: Get.height * 0.01),
                                AppButton(
                                  label: 'Continue',
                                  ontap:
                                      (opass.text.isNotEmpty &&
                                              npass.text.isNotEmpty &&
                                              cpass.text.isNotEmpty)
                                          ? () {
                                            current.value = 'check';
                                            update();
                                          }
                                          : null,
                                  bgColor:
                                      (opass.text.isNotEmpty &&
                                              npass.text.isNotEmpty &&
                                              cpass.text.isNotEmpty)
                                          ? AppColor.primaryColor
                                          : Colors.transparent,
                                ),
                              ],
                            )
                            : Column(
                              children: [
                                Image.asset('assets/images/check.png'),
                                SizedBox(height: Get.height * 0.01),
                                const AppText(
                                  'Your password has been changed successfully!',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.textColor,
                                ),
                                SizedBox(height: Get.height * 0.02),
                                AppButton(
                                  label: 'Continue',
                                  ontap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
