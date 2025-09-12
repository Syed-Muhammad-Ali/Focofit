import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/authentication/login_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class PasswordChangedPopup extends StatelessWidget {
  const PasswordChangedPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.sizeOf(context).height;
    final double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.offAll(() => const LoginPage()),
          icon: Image.asset('assets/icons/Back.png'),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Spacer(),
            Image.asset('assets/icons/done.png'),
            SizedBox(height: h * .02),
            AppText(
              'Your password has been changed',
              textAlign: TextAlign.center,
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              'You can now log back into your account and continue your progress.',
              textAlign: TextAlign.center,
              fontSize: 18,
              color: Colors.black,
            ),

            SizedBox(height: h * .02),
            const Spacer(),
            SizedBox(
              width: w,
              child: AppButton(
                label: 'Go back and log in',
                weight: FontWeight.w500,
                ontap: () {
                  Get.offAll(() => const LoginPage());
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
