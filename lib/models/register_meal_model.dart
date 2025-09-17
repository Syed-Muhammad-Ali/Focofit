import 'package:flutter/material.dart';

class RegisterMealModel {
  final String title;
  final String kcal;
  final String time;

  final String gram1;
  final Color color1;
  final String gram2;
  final Color color2;
  final String gram3;
  final Color color3;

  RegisterMealModel({
    required this.title,
    required this.kcal,
    required this.time,

    required this.gram1,
    required this.color1,
    required this.gram2,
    required this.color2,
    required this.gram3,
    required this.color3,
  });
}
