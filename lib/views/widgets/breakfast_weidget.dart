import 'package:flutter/material.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';

class BreakfastWidget extends StatelessWidget {
  final bool showDivider;
  final String? title;
  final String? gram;
  const BreakfastWidget({
    super.key,
    this.showDivider = true,
    this.title,
    this.gram,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //  SizedBox(height: Get.height * 0.02),
        // Title
        AppText(
          title ?? "Breakfast",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColor.textColor,
        ),
        const SizedBox(height: 12),

        // Row with two boxes
        Row(
          children: [
            // Percentage Box
            Container(
              height: 50,
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: AppText(
                  "33",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textColor,
                ),
              ),
            ),
            SizedBox(width: Get.width * 0.04),
            const AppText(
              "%",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColor.textColor,
            ),

            const SizedBox(width: 16),
            const Spacer(),
            // Kcal Box
            Container(
              height: 50,
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: AppText(
                  "1500",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textColor,
                ),
              ),
            ),
            SizedBox(width: Get.width * 0.04),

            AppText(
              gram ?? "kcal",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.textColor,
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Divider line
        if (showDivider) ...[
          const SizedBox(height: 12),
          const Divider(thickness: 1, color: Colors.grey),
        ],
      ],
    );
  }
}
