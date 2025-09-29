import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class ReportBugBottomSheet extends GetxController {
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
            child: GetBuilder<ReportBugBottomSheet>(
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
                        'Report error',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: const Divider(),
                      ),

                      // Text fields
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            AppTextfield(
                              hint:
                                  'Describe the error in as much detail as possible so that we can resolve it as quickly and as effectively as possible.',
                              maximumLines: 6,
                              minimumLines: 6,
                              height: 120,
                              titleSize: 16,
                              titleColor: AppColor.textColor,
                              ctr: cname,
                              onchanged: (val) {
                                update(); // Manually trigger UI update
                              },
                            ),
                            AppButton(
                              label: 'Continue',
                              ontap:
                                  (cname.text.isNotEmpty)
                                      ? () {
                                        update();
                                      }
                                      : null,
                              bgColor:
                                  (cname.text.isNotEmpty)
                                      ? AppColor.primaryColor
                                      : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            ),
          ),
    );
  }
}
