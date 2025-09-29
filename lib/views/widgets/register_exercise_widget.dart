import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focofit/views/pages/adding_excercises/register_screen_adding_exercise/register_screen_adding_exercise.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart' show AppColor;
import '../../models/register_exercise_model.dart';

class RegisterExerciseWidget extends StatelessWidget {
  final RegisterExerciseModel item;
  const RegisterExerciseWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => RegisterScreen());
      },
      child: SizedBox(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  item.title,

                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.textColor,
                ),
                SizedBox(height: Get.height * 0.01),
                Row(
                  children: [
                    AppText(
                      '${item.kcal} kcal (${item.time} min.),',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.greyColor,
                    ),
                    SizedBox(width: Get.width * 0.02),
                    Container(
                      height: 10,
                      width: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: item.color,
                      ),
                    ),
                    SizedBox(width: Get.width * 0.02),
                    AppText(
                      item.desc,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.greyColor,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primaryColor,
              ),
              child: Center(child: SvgPicture.asset('assets/icons/plus 1.svg')),
            ),
          ],
        ),
      ),
    );
  }
}
