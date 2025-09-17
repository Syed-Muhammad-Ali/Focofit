// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/authentication/register_flow/diet_follow_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class HeightPage extends StatefulWidget {
  const HeightPage({super.key});

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  late FixedExtentScrollController _metersController;
  late FixedExtentScrollController _centimetersController;
  int selectedMeters = 1; // Default: 1 meter
  int selectedCentimeters = 83; // Default: 83 cm

  @override
  void initState() {
    super.initState();
    _metersController = FixedExtentScrollController(
      initialItem: selectedMeters,
    );
    _centimetersController = FixedExtentScrollController(
      initialItem: selectedCentimeters,
    );
  }

  @override
  void dispose() {
    _metersController.dispose();
    _centimetersController.dispose();
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
                value: 0.4,
                borderRadius: BorderRadius.circular(10),
                minHeight: 20,
                backgroundColor: Color(0xff999999).withOpacity(.1),
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(width: w * .04),
            AppText(
              '4/10',
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
              'What is your height?',
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              'Your height helps us calculate your body mass index (BMI).',
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
                          controller: _metersController,
                          itemExtent: 50,
                          diameterRatio: 1.5,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedMeters = index;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return Center(
                                child: AppText(
                                  index.toString(),
                                  fontSize: selectedMeters == index ? 34 : 20,
                                  color:
                                      selectedMeters == index
                                          ? AppColor.primaryColor
                                          : Colors.black,
                                  fontWeight:
                                      selectedMeters == index
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              );
                            },
                            childCount: 10, // 0-9
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      // Centimeters wheel picker (01-99)
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .15,
                        child: ListWheelScrollView.useDelegate(
                          controller: _centimetersController,
                          itemExtent: 50,
                          diameterRatio: 1.5,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedCentimeters = index;
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
                                  fontSize:
                                      selectedCentimeters == index ? 34 : 20,
                                  color:
                                      selectedCentimeters == index
                                          ? AppColor.primaryColor
                                          : Colors.black,
                                  fontWeight:
                                      selectedCentimeters == index
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
                            'cm',
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
                  int totalHeight =
                      (selectedMeters * 100) + selectedCentimeters;
                  Get.to(() => DietFollowPage());
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
