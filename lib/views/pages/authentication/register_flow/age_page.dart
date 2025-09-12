import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/authentication/register_flow/height_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  late FixedExtentScrollController _scrollController;
  int selectedAge = 32; // Default selected age

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(
      initialItem: selectedAge - 18,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
                value: 0.3,
                borderRadius: BorderRadius.circular(10),
                minHeight: 20,
                backgroundColor: Color(0xff999999).withOpacity(.1),
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(width: w * .04),
            AppText(
              '3/10',
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
              'What is your age?',
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              'Your age helps us personalise recommendations based on your life stage and metabolic needs.',
              fontSize: 16,
              color: Colors.black,
            ),
            SizedBox(height: h * .02),

            Expanded(
              child: Center(
                child: SizedBox(
                  height: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Age wheel picker
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .2,
                        child: ListWheelScrollView.useDelegate(
                          controller: _scrollController,
                          itemExtent: 50,
                          diameterRatio: 1.5,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedAge = index + 18;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              int age = index + 18;
                              return Center(
                                child: AppText(
                                  age.toString(),
                                  fontSize: selectedAge == age ? 34 : 20,
                                  color:
                                      selectedAge == age
                                          ? AppColor.primaryColor
                                          : Colors.black,
                                  fontWeight:
                                      selectedAge == age
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              );
                            },
                            childCount: 83,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      // "anos" label
                      Center(
                        child: AppText(
                          'anos',
                          fontSize: 30,
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
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
                  Get.to(() => const HeightPage());
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
