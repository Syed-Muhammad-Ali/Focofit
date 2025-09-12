import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/authentication/register_flow/current_weight_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class ActivityLevelPage extends StatefulWidget {
  const ActivityLevelPage({super.key});

  @override
  State<ActivityLevelPage> createState() => _ActivityLevelPageState();
}

class _ActivityLevelPageState extends State<ActivityLevelPage> {
  int selectedIndex = -1;
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
                value: 0.7,
                borderRadius: BorderRadius.circular(10),
                minHeight: 20,
                backgroundColor: Color(0xff999999).withOpacity(.1),
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(width: w * .04),
            AppText(
              '7/10',
              textAlign: TextAlign.center,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: h,
        width: w,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'What is your activity level?',
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),

                    SizedBox(height: h * .02),
                    _buildGenderItem(
                      'Beginner',
                      'Limited physical activity. I do not usually exercise and spend most of my time sitting or lying down.',
                      0,
                    ),
                    SizedBox(height: h * .02),
                    _buildGenderItem(
                      'Lightly active',
                      'I do a few movements during the day, such as walking occasionally or standing up from time to time.',
                      1,
                    ),
                    SizedBox(height: h * .02),
                    _buildGenderItem(
                      'Moderately active',
                      'I usually engage in some exercise regularly or moderate physical activities, such as running or cycling outdoors.',
                      2,
                    ),
                    SizedBox(height: h * .02),
                    _buildGenderItem(
                      'Very active',
                      'I engage in intense physical activity or high-intensity training, such as weightlifting.',
                      3,
                    ),

                    SizedBox(height: h * .1),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 30,
              child: SizedBox(
                width: w,
                child: AppButton(
                  label: 'Continue',
                  ontap: () {
                    Get.to(() => const CurrentWeightPage());
                  },
                  bgColor:
                      selectedIndex == -1
                          ? Color(0xffD2D2D2)
                          : AppColor.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderItem(String title, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                selectedIndex == index
                    ? AppColor.primaryColor
                    : Color(0xffD2D2D2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              title,
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            Divider(color: Color(0xffD2D2D2), thickness: 1),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .8,
              child: AppText(label, fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
