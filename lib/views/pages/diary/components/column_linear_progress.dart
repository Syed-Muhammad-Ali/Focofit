import 'package:flutter/material.dart';
import 'package:focofit/views/widgets/text.dart';

class ColumnLinearProgress extends StatelessWidget {
  const ColumnLinearProgress({
    super.key,
    required this.title,
    required this.value,
    required this.valueText,
    required this.color,
  });
  final String title;
  final double value;
  final String valueText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
          title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * .26,
          child: LinearProgressIndicator(
            value: value,
            borderRadius: BorderRadius.circular(20),
            minHeight: 15,
            color: color,
            backgroundColor: Color(0xff999999).withOpacity(.1),
          ),
        ),
        SizedBox(height: 10),
        AppText(
          valueText,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ],
    );
  }
}
