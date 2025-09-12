import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/authentication/register_flow/medical_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class DietFollowPage extends StatefulWidget {
  const DietFollowPage({super.key});

  @override
  State<DietFollowPage> createState() => _DietFollowPageState();
}

class _DietFollowPageState extends State<DietFollowPage> {
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
                value: 0.5,
                borderRadius: BorderRadius.circular(10),
                minHeight: 20,
                backgroundColor: Color(0xff999999).withOpacity(.1),
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(width: w * .04),
            AppText(
              '5/10',
              textAlign: TextAlign.center,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'What diet do you follow?',
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),

                  SizedBox(height: h * .02),
                  _buildGenderItem(
                    'Ketogenic',
                    'A high-fat, low-carbohydrate diet designed to put the body into a state of ketosis for weight loss.',
                    0,
                  ),
                  SizedBox(height: h * .02),
                  _buildGenderItem(
                    'Paleo',
                    'Focus on eating whole, unprocessed foods similar to those consumed during the Paleolithic era.',
                    1,
                  ),
                  SizedBox(height: h * .02),
                  _buildGenderItem(
                    'Clean eating',
                    'Focus on eating whole, unprocessed foods similar to those consumed during the Paleolithic era.',
                    2,
                  ),
                  SizedBox(height: h * .02),
                  _buildGenderItem(
                    'Low fat',
                    'Focus on eating whole, unprocessed foods similar to those consumed during the Paleolithic era.',
                    3,
                  ),
                  SizedBox(height: h * .02),
                  _buildGenderItem(
                    'Low carb',
                    'Focus on eating whole, unprocessed foods similar to those consumed during the Paleolithic era.',
                    4,
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
                  Get.to(() => const MedicalPage());
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
