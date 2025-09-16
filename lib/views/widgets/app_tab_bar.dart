import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/text.dart';

class CustomTabBar extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTabBar({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: AppText(
            title,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColor.whiteColor : AppColor.greyColor,
          ),
        ),
      ),
    );
  }
}
