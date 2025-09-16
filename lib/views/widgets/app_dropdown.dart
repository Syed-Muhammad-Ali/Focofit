// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/text.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? selectedValue;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final double? fontSize;
  final Color? hintColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? dropdownColor;
  final Color? containerColor;
  final Color? iconColor;
  final Color? dropListColor;
  double? radius;
  double? height;

  AppDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.hintText = 'Select',
    this.fontSize,
    this.hintColor,
    this.textColor,
    this.borderColor,
    this.dropdownColor,
    this.containerColor,
    this.iconColor,
    this.dropListColor,
    this.radius,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: containerColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(radius ?? 10),
        border: Border.all(color: borderColor ?? Color(0xff999999)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: selectedValue,
          hint: AppText(
            hintText,
            fontSize: fontSize ?? 14,
            fontWeight: FontWeight.w400,
            color: hintColor ?? AppColor.textColor,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: iconColor ?? AppColor.blackColor,
          ),
          isExpanded: true,
          dropdownColor: dropdownColor ?? Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),

          selectedItemBuilder: (BuildContext context) {
            return items.map((T item) {
              return Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  item.toString(),
                  fontSize: fontSize ?? 12,
                  fontWeight: FontWeight.w400,
                  color: dropListColor ?? AppColor.textColor,
                ),
              );
            }).toList();
          },

          onChanged: onChanged,
          items:
              items.map((T item) {
                final isSelected = item == selectedValue;
                return DropdownMenuItem<T>(
                  value: item,
                  child: AppText(
                    item.toString(),
                    fontSize: fontSize ?? 12,
                    fontWeight: FontWeight.w400,
                    color:
                        isSelected
                            ? AppColor.textColor
                            : (textColor ?? AppColor.textColor),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
