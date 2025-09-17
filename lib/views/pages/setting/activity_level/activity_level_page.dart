import 'package:flutter/material.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/diary_container_tile.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../controllers/activity_level_controller.dart'
    show LevelController;
import '../../../widgets/header_container.dart';
import '../../../widgets/text.dart' show AppText;

class ActivityLevelPage extends StatelessWidget {
  final LevelController controller = Get.put(LevelController());
  ActivityLevelPage({super.key});

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
                      'Activity Level',
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.levellsit.length,
                  itemBuilder: (context, index) {
                    final level = controller.levellsit[index];
                    return Column(
                      children: [
                        DiaryContainerTile(
                          child: SizedBox(
                            height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  level.level,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.textColor,
                                ),
                                AppText(
                                  level.desc,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.textColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                      ],
                    );
                  },
                ),
                const Spacer(),
                AppButton(label: 'Save change'),
                SizedBox(height: Get.height * 0.02),
              ],
            ).paddingSymmetric(vertical: 10, horizontal: 20),
          ),
        ],
      ),
    );
  }
}
