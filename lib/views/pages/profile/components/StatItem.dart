import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:google_fonts/google_fonts.dart';


class StatItem {
  final String label;
  final String value;
  final String unit;

  StatItem(this.label, this.value, this.unit);

  Widget build() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
          label,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColor.textColor,
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            text: value,
            style: GoogleFonts.notoSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColor.textColor,
            ),
            children: [
              TextSpan(
                text: " $unit",
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}