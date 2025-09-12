import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/authentication/register_flow/dietry_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class GoalWeightPage extends StatefulWidget {
  const GoalWeightPage({super.key});

  @override
  State<GoalWeightPage> createState() => _GoalWeightPageState();
}

class _GoalWeightPageState extends State<GoalWeightPage> {
  late FixedExtentScrollController _weightController;
  int selectedWeight = 1; // Default: 1 meter

  @override
  void initState() {
    super.initState();
    _weightController = FixedExtentScrollController(
      initialItem: selectedWeight,
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.sizeOf(context).height;
    final double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Image.asset('assets/icons/Back.png'),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: 0.9,
                borderRadius: BorderRadius.circular(10),
                minHeight: 20,
                backgroundColor: Color(0xff999999).withOpacity(.1),
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(width: w * .04),
            AppText(
              '9/10',
              textAlign: TextAlign.center,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              'What is your target weight?',
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              'What weight would you like to achieve? Selecting a goal helps us create personalised plans for you.',
              fontSize: 16,
              color: Colors.black,
            ),
            SizedBox(height: h * .02),

            // Height wheel picker container
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Meters wheel picker (0-9)
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .15,
                        child: ListWheelScrollView.useDelegate(
                          controller: _weightController,
                          itemExtent: 50,
                          diameterRatio: 1.5,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedWeight = index;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return Center(
                                child: AppText(
                                  index.toString(),
                                  fontSize: selectedWeight == index ? 34 : 20,
                                  color:
                                      selectedWeight == index
                                          ? AppColor.primaryColor
                                          : Colors.black,
                                  fontWeight:
                                      selectedWeight == index
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              );
                            },
                            childCount: 1000, // 0-9
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      AppText(
                        ',',
                        fontSize: 30,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      // Centimeters wheel picker (01-99)
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .15,
                        child: ListWheelScrollView.useDelegate(
                          controller: _weightController,
                          itemExtent: 50,
                          diameterRatio: 1.5,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedWeight = index;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return Center(
                                child: AppText(
                                  index.toString().padLeft(
                                    2,
                                    '0',
                                  ), // 01, 02, etc.
                                  fontSize: selectedWeight == index ? 34 : 20,
                                  color:
                                      selectedWeight == index
                                          ? AppColor.primaryColor
                                          : Colors.black,
                                  fontWeight:
                                      selectedWeight == index
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              );
                            },
                            childCount: 100, // 00-99
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      // "cm" label
                      SizedBox(
                        child: Center(
                          child: AppText(
                            'kg',
                            fontSize: 30,
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              width: w,
              child: AppButton(
                label: 'Continue',
                ontap: () {
                  int weight = selectedWeight;
                  Get.to(() => const DietryPage());
                },
                bgColor: AppColor.primaryColor,
              ),
            ),
            SizedBox(height: h * .02),
          ],
        ),
      ),
    );
  }
}
