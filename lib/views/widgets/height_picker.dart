import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/text.dart';

class HeightPicker extends StatefulWidget {
  const HeightPicker({super.key});

  @override
  HeightPickerState createState() => HeightPickerState();
}

class HeightPickerState extends State<HeightPicker> {
  int selectedHeight = 170; // default starting point

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Height Picker
          SizedBox(
            width: 100,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: selectedHeight - 100, // start from 100 cm
              ),
              itemExtent: 50,
              useMagnifier: false,
              selectionOverlay: Container(),
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedHeight = 100 + index; // range 100–250
                });
              },
              children: List.generate(151, (index) {
                int value = 100 + index; // valid height values
                int diff = (value - selectedHeight).abs();

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

          // cm label
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Text(
              "cm",
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
