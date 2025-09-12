import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/authentication/register_flow/age_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
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
                value: 0.2,
                borderRadius: BorderRadius.circular(10),
                minHeight: 20,
                backgroundColor: Color(0xff999999).withOpacity(.1),
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(width: w * .04),
            AppText(
              '2/10',
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
              'What is your gender?',
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              'To personalise your experience, please tell us your gender:',
              fontSize: 16,
              color: Colors.black,
            ),
            SizedBox(height: h * .02),
            _buildGenderItem('Male', 0),
            SizedBox(height: h * .02),
            _buildGenderItem('Female', 1),
            SizedBox(height: h * .02),
            _buildGenderItem('Prefer not to say', 2),
            const Spacer(),
            SizedBox(
              width: w,
              child: AppButton(
                label: 'Continue',
                ontap: () {
                  Get.to(() => const AgePage());
                },
                bgColor:
                    selectedIndex == -1
                        ? Color(0xffD2D2D2)
                        : AppColor.primaryColor,
              ),
            ),
            SizedBox(height: h * .02),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderItem(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: 60,
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
        child: Row(
          children: [AppText(label, fontSize: 16, color: Colors.black)],
        ),
      ),
    );
  }
}
