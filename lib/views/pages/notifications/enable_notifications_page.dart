import 'package:flutter/material.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../widgets/custom_toggle_buttn.dart';
import '../../widgets/diary_container_tile.dart';
import '../../widgets/header_container.dart';
import '../../widgets/text.dart' show AppText;

class EnableNotificationsPage extends StatelessWidget {
  const EnableNotificationsPage({super.key});

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
                      'Notifications',
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
                DiaryContainerTile(
                  child: SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          'Enable all notifications',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.textColor,
                        ),
                        CustomToggleButton(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),

                DiaryContainerTile(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top row (title + toggle)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              'Meal Reminder',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textColor,
                            ),
                            CustomToggleButton(), // your custom toggle widget
                          ],
                        ),

                        const SizedBox(height: 8),
                        const Divider(thickness: 1, color: Colors.grey),

                        const SizedBox(height: 8),

                        // Meal rows
                        ...List.generate(4, (index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    'Breakfast',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.textColor,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: AppText(
                                      '08:00',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.textColor,
                                    ),
                                  ),
                                ],
                              ),
                              if (index != 3) ...[
                                const SizedBox(height: 8),
                                const Divider(thickness: 1, color: Colors.grey),
                                const SizedBox(height: 8),
                              ],
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: Get.height * 0.02),
              ],
            ).paddingSymmetric(vertical: 15, horizontal: 10),
          ),
        ],
      ), // ✅ Put your button here
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AppButton(label: 'Save'),
      ),
    );
  }
}
