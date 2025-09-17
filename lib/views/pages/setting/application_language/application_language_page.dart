import 'package:flutter/material.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import 'change_labguage_bottom_sheet.dart';
import '../../../widgets/header_container.dart';
import '../../../widgets/text.dart' show AppText;

class ApplicationLanguagePage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  ApplicationLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Column(
        children: [
          HeaderContainer(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 40),
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
                  const Center(
                    child: AppText(
                      'Application Language',
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
          Expanded(
            child: Column(
              children: [
                AppTextfield(
                  ctr: _controller,
                  labelText: 'Brazilian Portuguese',
                ),
                AppTextfield(
                  ctr: controller,
                  labelText: 'Brazilian Portuguese',
                ),
                const Spacer(),
                AppButton(
                  label: 'Save',
                  ontap:
                      () => ChangeLanguageBottomSheet().showLogMealBottomSheet(
                        context,
                      ),
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ).paddingSymmetric(vertical: 10, horizontal: 20),
          ),
        ],
      ),
    );
  }
}
