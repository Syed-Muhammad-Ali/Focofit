import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/authentication/login_page.dart';
import 'package:focofit/views/pages/authentication/register_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
              'assets/images/header.png',
              height: height * .3,
              width: width,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: height * .08,
              child: Image.asset('assets/icons/logo.png', height: height * .15),
            ),
            Positioned(
              top: height * .33,
              child: Column(
                children: [
                  AppText(
                    'Shall we get started?',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  AppText(
                    'Embark on your new fitness journey',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textColor,
                  ),
                  SizedBox(height: height * .08),
                  SizedBox(
                    width: width,
                    child: AppButton(
                      ontap: () {},
                      rowElements: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/google.png'),
                          const Spacer(),
                          AppText(
                            'Continue with Google',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          const Spacer(),
                        ],
                      ),
                      label: '',
                      bgColor: Colors.white,
                      borderColor: Color(0xffD2D2D2),
                      useborder: true,
                      isElevation: false,
                    ),
                  ),

                  SizedBox(height: height * .02),
                  SizedBox(
                    width: width,
                    child: AppButton(
                      ontap: () {},
                      rowElements: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/apple.png'),
                          const Spacer(),
                          AppText(
                            'Continue with Apple',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          const Spacer(),
                        ],
                      ),
                      label: '',
                      bgColor: AppColor.textColor,

                      isElevation: false,
                    ),
                  ),

                  SizedBox(height: height * .02),
                  SizedBox(
                    width: width,
                    child: AppButton(
                      ontap: () {},
                      rowElements: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/facebook.png'),
                          const Spacer(),
                          AppText(
                            'Continue with Facebook',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          const Spacer(),
                        ],
                      ),
                      label: '',
                      bgColor: Color(0xff407BFF),
                      isElevation: false,
                    ),
                  ),

                  SizedBox(height: height * .05),
                  SizedBox(
                    width: width,
                    child: AppButton(
                      ontap: () {
                        Get.to(() => const RegisterPage());
                      },
                      label: 'Create account',
                      isElevation: false,
                    ),
                  ),
                  SizedBox(height: height * .02),
                  SizedBox(
                    width: width,
                    child: AppButton(
                      bgColor: Colors.white,
                      borderColor: AppColor.textColor,
                      useborder: true,
                      txtClr: AppColor.textColor,
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      label: 'Log in',
                      isElevation: false,
                    ),
                  ),
                  SizedBox(height: height * .04),
                  SizedBox(
                    width: width * .8,
                    child: AppText(
                      'By continuing, you confirm that you have read and agree to our Terms of Use and Privacy Policy',
                      fontSize: 12,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
