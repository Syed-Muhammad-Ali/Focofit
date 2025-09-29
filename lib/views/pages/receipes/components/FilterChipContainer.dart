import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/text.dart';

class FilterChipContainer extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChipContainer({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : AppColor.whiteColor,
          border: Border.all(
            color: isSelected ? AppColor.primaryColor : AppColor.greyColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: AppText(
          label,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : AppColor.textColor,
        ),
      ),
    );
  }
}
