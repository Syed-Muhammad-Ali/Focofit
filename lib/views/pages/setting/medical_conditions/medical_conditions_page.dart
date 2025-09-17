import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:get/get.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/app_textfield.dart';
import '../../../widgets/header_container.dart';
import '../../../widgets/text.dart';

class MedicalConditionsPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  MedicalConditionsPage({super.key});

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
                  Center(
                    child: AppText(
                      'Medical Conditions',
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
                AppTextfield(ctr: _controller, labelText: 'Hypertension'),
                AppTextfield(
                  ctr: controller,
                  labelText: 'Diabetes or insulin resistance',
                ),
                AppTextfield(ctr: _controller, labelText: 'Asthma'),
                AppTextfield(ctr: controller, labelText: 'High cholesterol'),
                AppTextfield(ctr: _controller, labelText: 'Arrhythmia'),
                AppTextfield(ctr: controller, labelText: 'Thyroid diseases'),
                AppTextfield(ctr: controller, labelText: "I don't have any"),
                const Spacer(),
                AppButton(label: 'Save'),
                SizedBox(height: Get.height * 0.04),
              ],
            ).paddingSymmetric(vertical: 0, horizontal: 20),
          ),
        ],
      ),
    );
  }
}
