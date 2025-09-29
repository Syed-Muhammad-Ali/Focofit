import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart' show AppColor;
import '../../../../controllers/register_exercise_controller.dart'
    show RegisterExerciseController;
import '../../../widgets/register_exercise_widget.dart';

class AllRegisterExercisePage extends StatelessWidget {
  final RegisterExerciseController rxController = Get.put(
    RegisterExerciseController(),
  );
  AllRegisterExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: rxController.rxlist.length,
              itemBuilder: (context, index) {
                final item = rxController.rxlist[index];
                return Column(
                  children: [
                    RegisterExerciseWidget(item: item),
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
