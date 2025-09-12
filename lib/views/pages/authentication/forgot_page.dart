import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/authentication/recover_pass_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final TextEditingController emailCtr = TextEditingController();

  bool _isFormValid = false;

  bool isRemember = false;

  @override
  void initState() {
    super.initState();
    emailCtr.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    setState(() {
      _isFormValid = emailCtr.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    emailCtr.dispose();

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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * .03),
              AppText(
                'Recover password',
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              AppText(
                'Enter your email below to receive a link to change your password.',
                fontSize: 18,
                color: Colors.black,
              ),
              AppTextfield(
                ctr: emailCtr,
                hint: 'Enter your email',
                prefixIcon: Image.asset('assets/icons/email.png'),
              ),
              const Spacer(),
              SizedBox(
                width: w,
                child: AppButton(
                  label: 'Continue',
                  weight: FontWeight.w500,
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecoverPassPage(),
                      ),
                    );
                  },
                  bgColor:
                      _isFormValid ? AppColor.primaryColor : Color(0xffD2D2D2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
