// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/custom_toggle_buttn.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/breakfast_weidget.dart';
import '../../../widgets/diary_container_tile.dart';
import '../../../widgets/text.dart';

class CalorieGoal extends StatelessWidget {
  const CalorieGoal({super.key});

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
                      'Calorie Goal',
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
          Column(
            children: [
              DiaryContainerTile(
                child: SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        'Automatically recalculate limit',
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
                child: Column(
                  children: [
                    BreakfastWidget(title: 'Breakfast'),
                    BreakfastWidget(title: 'Lunch'),
                    BreakfastWidget(title: 'Dinner'),
                    BreakfastWidget(title: 'Snacks', showDivider: false),
                  ],
                ).paddingSymmetric(vertical: 10, horizontal: 10),
              ),
              SizedBox(height: Get.height * 0.06),
              AppButton(label: 'Save'),
            ],
          ).paddingSymmetric(vertical: 20, horizontal: 15),
        ],
      ),
    );
  }
}
