import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart' show AppColor;

import '../../../../controllers/register_meal_controller.dart';
import '../../../widgets/register_meal_widget.dart';

class FavoritesRegisterMealPage extends StatelessWidget {
  final RegisterMealController rmController = Get.put(RegisterMealController());
  FavoritesRegisterMealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: rmController.rxlist.length,
              itemBuilder: (context, index) {
                final item = rmController.rxlist[index];
                return Column(
                  children: [
                    RegisterMealWidget(item: item),
                    SizedBox(height: Get.height * 0.02),
                  ],
                );
              },
            ),
          ),
        ],
      ).paddingSymmetric(vertical: 0),
    );
  }
}
