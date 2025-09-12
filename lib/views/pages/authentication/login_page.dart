import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/authentication/forgot_page.dart';
import 'package:focofit/views/pages/authentication/register_page.dart';
import 'package:focofit/views/pages/bnb/bnb_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController passwordCtr = TextEditingController();
  bool _isFormValid = false;
  bool isRemember = false;

  @override
  void initState() {
    super.initState();
    emailCtr.addListener(_checkFormValidity);
    passwordCtr.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    setState(() {
      _isFormValid = emailCtr.text.isNotEmpty && passwordCtr.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    emailCtr.dispose();
    passwordCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.sizeOf(context).height;
    final double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Image.asset('assets/icons/Back.png'),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * .03),
              AppText(
                'Log in to your account',
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              AppText(
                'Log in to your account to access your personalised plan.',
                fontSize: 18,
                color: Colors.black,
              ),
              AppTextfield(
                ctr: emailCtr,
                hint: 'Enter your email',
                prefixIcon: Image.asset('assets/icons/email.png'),
              ),
              AppTextfield(
                ctr: passwordCtr,
                hint: 'Enter your password',
                isPasswordField: true,
                prefixIcon: Image.asset('assets/icons/Keyboard.png'),
              ),
              SizedBox(height: h * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    activeColor: AppColor.primaryColor,
                    value: isRemember,
                    onChanged: (value) {
                      setState(() {
                        isRemember = value ?? false;
                      });
                    },
                  ),
                  AppText(
                    'Remember me',
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPage()),
                      );
                    },
                    child: AppText(
                      'Forgot password?',
                      fontSize: 16,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * .02),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: AppText(
                    'Don’t have an account? Sign up',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: h * .02),
              SizedBox(
                width: w,
                child: AppButton(
                  label: 'Login',
                  weight: FontWeight.w500,
                  ontap: () {
                    Get.to(() => const BnbPage());
                  },
                  bgColor:
                      _isFormValid ? AppColor.primaryColor : Color(0xffD2D2D2),
                ),
              ),
              SizedBox(height: h * .02),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: w * .02),
                  AppText('Or', fontSize: 16, color: Colors.black),
                  SizedBox(width: w * .02),
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * .04),
              SizedBox(
                width: w,
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

              SizedBox(height: h * .02),
              SizedBox(
                width: w,
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

              SizedBox(height: h * .02),
              SizedBox(
                width: w,
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
            ],
          ),
        ),
      ),
    );
  }
}
