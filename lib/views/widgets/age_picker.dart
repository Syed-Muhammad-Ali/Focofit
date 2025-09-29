import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/text.dart';

class AgePicker extends StatefulWidget {
  const AgePicker({super.key});

  @override
  AgePickerState createState() => AgePickerState();
}

class AgePickerState extends State<AgePicker> {
  int selectedAge = 25; // default starting point

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Age Picker
          SizedBox(
            width: 100,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: selectedAge, // start from 25
              ),
              itemExtent: 50,
              useMagnifier: false,
              selectionOverlay: Container(),
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedAge = index; // range 0–100+
                });
              },
              children: List.generate(121, (index) {
                int value = index; // valid age values 0–120
                int diff = (value - selectedAge).abs();

                // Default style
                Color color = Colors.grey;
                double fontSize = 24;
                FontWeight weight = FontWeight.w500;

                if (diff == 0) {
                  color = AppColor.primaryColor;
                  fontSize = 36; // ✅ selected size 32
                  weight = FontWeight.w600;
                } else if (diff == 1) {
                  color = AppColor.textColor;
                  fontSize = 30;
                } else if (diff == 2) {
                  color = AppColor.textColor;
                  fontSize = 25;
                } else if (diff == 3) {
                  color = AppColor.textColor.withOpacity(0.7);
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

          // Age label
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Text(
              "Years",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w600,
                color: AppColor.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
