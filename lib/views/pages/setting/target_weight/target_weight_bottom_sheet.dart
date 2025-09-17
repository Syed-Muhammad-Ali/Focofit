import 'package:flutter/material.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

import '../../../widgets/weight_picker.dart';

class TargetWeightBottomSheet extends GetxController {
  final email = TextEditingController();
  final cemail = TextEditingController();

  void showLogMealBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: GetBuilder<TargetWeightBottomSheet>(
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
                        'Target Weight',
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              WeightPicker(),
                              const Spacer(),
                              AppButton(label: 'Save change'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.03),
                    ],
                  ),
            ),
          ),
    );
  }
}
