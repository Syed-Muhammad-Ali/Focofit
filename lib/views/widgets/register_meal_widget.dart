import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart' show AppColor;
import '../../models/register_meal_model.dart';
import '../pages/adding_meal/register_screen_adding_meal/register_screen_adding_meal.dart';

class RegisterMealWidget extends StatefulWidget {
  final RegisterMealModel item;
  const RegisterMealWidget({super.key, required this.item});

  @override
  State<RegisterMealWidget> createState() => _RegisterMealWidgetState();
}

class _RegisterMealWidgetState extends State<RegisterMealWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => RegisterScreenAddingMeal());
      },
      child: SizedBox(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  widget.item.title,

                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.textColor,
                ),
                SizedBox(height: Get.height * 0.01),
                Row(
                  children: [
                    AppText(
                      '${widget.item.kcal} kcal (${widget.item.time} g.),',
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
                        color: widget.item.color1,
                      ),
                    ),
                    SizedBox(width: Get.width * 0.02),
                    AppText(
                      widget.item.gram1,
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
                        color: widget.item.color2,
                      ),
                    ),
                    SizedBox(width: Get.width * 0.02),
                    AppText(
                      widget.item.gram2,
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
                        color: widget.item.color3,
                      ),
                    ),
                    SizedBox(width: Get.width * 0.02),
                    AppText(
                      widget.item.gram3,
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
