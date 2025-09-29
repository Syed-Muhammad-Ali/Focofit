// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/text.dart';

class WeightPicker extends StatefulWidget {
  const WeightPicker({super.key});

  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  int selectedKg = 85;
  int selectedGrams = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // KG Picker
          SizedBox(
            width: 80,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: selectedKg - 50,
              ),
              itemExtent: 50,
              useMagnifier: false,
              selectionOverlay: Container(),
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedKg = 50 + index;
                });
              },
              children: List.generate(150, (index) {
                int value = 50 + index;
                int diff = (value - selectedKg).abs();

                // Default style
                Color color = Colors.grey;
                double fontSize = 24;
                FontWeight weight = FontWeight.w500;

                if (diff == 0) {
                  color = AppColor.primaryColor;
                  fontSize = 36;
                  weight = FontWeight.w600;
                } else if (diff == 1) {
                  color = AppColor.textColor;
                  fontSize = 30;
                } else if (diff == 2) {
                  color = AppColor.textColor;
                  fontSize = 26;
                } else if (diff == 3) {
                  color = AppColor.textColor;
                  fontSize = 22;
                }

                return Center(
                  child: AppText(
                    value.toString(),

                    fontSize: fontSize,
                    fontWeight: weight,
                    color: color,
                  ),
                );
              }),
            ),
          ),

          // Comma
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: AppText(
              ",",

              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
          ),

          // Grams Picker
          SizedBox(
            width: 80,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: selectedGrams,
              ),
              itemExtent: 50,
              useMagnifier: false,
              selectionOverlay: Container(),
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedGrams = index;
                });
              },
              children: List.generate(100, (index) {
                int diff = (index - selectedGrams).abs();

                Color color = Colors.grey;
                double fontSize = 24;
                FontWeight weight = FontWeight.w500;

                if (diff == 0) {
                  color = AppColor.primaryColor;
                  fontSize = 36;
                  weight = FontWeight.w600;
                } else if (diff == 1) {
                  color = AppColor.textColor;
                  fontSize = 30;
                } else if (diff == 2) {
                  color = AppColor.textColor;
                  fontSize = 26;
                } else if (diff == 3) {
                  color = AppColor.textColor;
                  fontSize = 22;
                }

                return Center(
                  child: AppText(
                    index.toString().padLeft(2, '0'),

                    fontSize: fontSize,
                    fontWeight: weight,
                    color: color,
                  ),
                );
              }),
            ),
          ),

          // KG label
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Text(
              "kg",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
