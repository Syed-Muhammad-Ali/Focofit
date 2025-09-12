import 'package:flutter/material.dart';
import 'package:focofit/views/pages/diary/components/column_linear_progress.dart';
import 'package:focofit/views/pages/diary/components/semi_circular_progress.dart';
import 'package:focofit/views/widgets/diary_container_tile.dart';
import 'package:focofit/views/widgets/text.dart';

class GoalTile extends StatelessWidget {
  const GoalTile({super.key});

  @override
  Widget build(BuildContext context) {
    return DiaryContainerTile(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .86,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ColumnTextData(title: 'Daily goal', value: '2000'),
                        SizedBox(height: 10),
                        ColumnTextData(title: 'Consumed', value: '1240'),
                        SizedBox(height: 10),
                        ColumnTextData(title: 'Burned', value: '500'),
                      ],
                    ),

                    SemiCircularProgressBar(
                      remainingCalories: 1240,
                      totalCalories: 2000,
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * .02),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .86,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ColumnLinearProgress(
                      title: 'Carboidratos',
                      value: 0.5,
                      valueText: '750 / 1250 g',
                      color: Color(0xff00D923),
                    ),
                    SizedBox(width: 10),
                    ColumnLinearProgress(
                      title: 'Proteínas',
                      value: 0.5,
                      valueText: '425 / 640 g',
                      color: Color(0xffFF274E),
                    ),
                    SizedBox(width: 10),
                    ColumnLinearProgress(
                      title: 'Gorduras',
                      value: 0.5,
                      valueText: '345 / 450 g',
                      color: Color(0xffFFDF39),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ColumnTextData extends StatelessWidget {
  const ColumnTextData({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        AppText(
          value,
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ],
    );
  }
}
