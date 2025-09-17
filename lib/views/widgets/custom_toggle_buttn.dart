import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';

class CustomToggleButton extends StatefulWidget {
  const CustomToggleButton({super.key});

  @override
  State<CustomToggleButton> createState() => CustomToggleButtonState();
}

class CustomToggleButtonState extends State<CustomToggleButton> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isToggled = !isToggled;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 70,
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isToggled ? AppColor.primaryColor : Colors.grey[400],
          ),
          child: Align(
            alignment: isToggled ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
