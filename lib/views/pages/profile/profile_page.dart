import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/diary/components/diary_header.dart';
import 'package:focofit/views/pages/profile/components/ChartSection.dart';
import 'package:focofit/views/pages/profile/components/CustomTable.dart';
import 'package:focofit/views/pages/profile/components/StatItem.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> weekDays = [
    "31\nSun",
    "1\nMon",
    "2\nTue",
    "3\nWed",
    "4\nThu",
    "5\nFri",
    "6\nSat",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DiaryHeader(
              icon: 'assets/icons/setting-2.svg',
              showBadge: false,
              onTap: () {},
            ),
            ChartSection(
              title: "Weight history",
              stats: [
                StatItem("Home", "60,5", "kg"),
                StatItem("Current", "58,1", "kg"),
                StatItem("Meta", "55", "kg"),
              ],
              data: [
                [80, 60, 75, 70, 90, 75, 100],
              ],
              weekDays: weekDays,
              colors: [AppColor.primaryColor],
            ),
            ChartSection(
              title: "ICM history",
              stats: [
                StatItem("Home", "30,50", ""),
                StatItem("Current", "25,62", ""),
                StatItem("Meta", "20,10", ""),
              ],
              data: [
                [100, 75, 35, 90, 45, 88, 110],
              ],
              weekDays: weekDays,
              colors: [AppColor.primaryColor],
              maxY: 120,
            ),
            ChartSection(
              title: "Activities history",
              stats: [
                StatItem("Total duration", "42h", "15m"),
                StatItem("kcal burned", "8241", "kcal"),
              ],
              data: [
                [1.5, 2.0, 2.2, 1.8, 3.5, 2.0, 2.5],
              ],
              weekDays: weekDays,
              colors: [Color(0xffA055FF)],
              maxY: 4,
            ),
            ChartSection(
              title: "Food history",
              stats: [
                StatItem("Kcal consumed", "7421", "kcal"),
                StatItem("kcal burned", "5125", "kcal"),
              ],
              data: [
                [500, 800, 700, 900, 850, 950, 1000],
                [600, 700, 800, 850, 900, 950, 970],
              ],
              weekDays: weekDays,
              colors: [Color(0xff1AB2D2), AppColor.primaryColor],
              legends: ["Consumed", "Fires"],
              extraContent: CustomTable(
                headers: ["Snack", "Participation", "Calories"],
                rows: [
                  ["Breakfast", "30 %", "9999 kcal"],
                  ["Lunch", "30 %", "9999 kcal"],
                  ["To have lunch", "30 %", "9999 kcal"],
                  ["Snacks", "10 %", "9999 kcal"],
                ],
              ),
              maxY: 1200,
            ),
            ChartSection(
              title: "Macronutrients history",
              stats: [
                StatItem("Carbohydrate", "1000", "g"),
                StatItem("Protein", "1000", "g"),
                StatItem("Fat", "1000", "g"),
              ],
              data: [
                [100, 300, 350, 480, 590, 510, 600],
                [150, 280, 360, 470, 500, 610, 700],
                [50, 100, 280, 390, 410, 520, 630],
              ],
              weekDays: weekDays,
              colors: [Color(0xff00D923), Color(0xffFF274E), Color(0xffFFDF39)],
              legends: ["Carbohydrate", "Protein", "Fat"],
              extraContent: CustomTable(
                headers: ["Snack", "Carb", "Prot", "Gord"],
                rows: [
                  ["Breakfast", "2800 g", "1500 g", "1500 g"],
                  ["Lunch", "2800 g", "1500 g", "1500 g"],
                  ["To have lunch", "2800 g", "1500 g", "1500 g"],
                  ["Snacks", "2800 g", "1500 g", "1500 g"],
                ],
              ),
              maxY: 700,
            ),
            ChartSection(
              title: "Fasting history",
              stats: [StatItem("Total duration", "62h", "15m")],
              data: [
                [12, 14, 16, 20, 18, 19, 17],
              ],
              weekDays: weekDays,
              colors: [AppColor.primaryColor],
              maxY: 24,
            ),
          ],
        ),
      ),
    );
  }
}
