import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/text.dart';





class CustomTable extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;

  const CustomTable({super.key, required this.headers, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              headers
                  .map(
                    (h) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AppText(
                          h,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColor.textColor,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),

        const SizedBox(height: 4),
        ...rows.map(
          (r) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                r
                    .map(
                      (cell) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: AppText(
                            cell,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColor.textColor,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}
