import 'package:flutter/material.dart';
import 'package:focofit/views/pages/diary/components/diary_header.dart';
import 'package:focofit/views/pages/diary/components/goal_tile.dart';
import 'package:focofit/views/pages/diary/components/home_tiles.dart';
import 'package:focofit/views/widgets/bottom_sheet.dart';
import 'package:focofit/views/widgets/calendar_widget.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          DiaryHeader(),
          SizedBox(height: 20),
          CalendarWidget(),
          SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * .6,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GoalTile(),
                    SizedBox(height: MediaQuery.sizeOf(context).height * .02),
                    //breakfast
                    BrekaFastTile(
                      onTap:
                          () =>
                              AppBottomSheet().showLogMealBottomSheet(context),
                    ),

                    SizedBox(height: MediaQuery.sizeOf(context).height * .02),
                    //lunch
                    LunchTile(
                      onTap:
                          () =>
                              AppBottomSheet().showLogMealBottomSheet(context),
                    ),

                    SizedBox(height: MediaQuery.sizeOf(context).height * .02),
                    //Dinner
                    DinnerTile(
                      onTap:
                          () =>
                              AppBottomSheet().showLogMealBottomSheet(context),
                    ),

                    SizedBox(height: MediaQuery.sizeOf(context).height * .02),
                    SnacksTile(
                      onTap:
                          () =>
                              AppBottomSheet().showLogMealBottomSheet(context),
                    ),

                    SizedBox(height: MediaQuery.sizeOf(context).height * .02),
                    //Exercises
                    ExercisesTile(onTap: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
