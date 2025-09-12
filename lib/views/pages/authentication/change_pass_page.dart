import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/authentication/password_changed_popup.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  final TextEditingController confirmPassCtr = TextEditingController();
  final TextEditingController newPassCtr = TextEditingController();
  bool _isFormValid = false;
  bool isRemember = false;

  @override
  void initState() {
    super.initState();
    confirmPassCtr.addListener(_checkFormValidity);
    newPassCtr.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    setState(() {
      _isFormValid =
          confirmPassCtr.text.isNotEmpty && newPassCtr.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    confirmPassCtr.dispose();
    newPassCtr.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * .03),
            AppText(
              'Password change',
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              'Create a new password to regain access to your account',
              fontSize: 18,
              color: Colors.black,
            ),
            AppTextfield(
              ctr: confirmPassCtr,
              hint: 'Enter your new password',
              isPasswordField: true,
              prefixIcon: Image.asset('assets/icons/Keyboard.png'),
            ),
            AppTextfield(
              ctr: newPassCtr,
              hint: 'Repeat your new password',
              isPasswordField: true,
              prefixIcon: Image.asset('assets/icons/Keyboard.png'),
            ),
            SizedBox(height: h * .02),
            const Spacer(),
            SizedBox(
              width: w,
              child: AppButton(
                label: 'Change password',
                weight: FontWeight.w500,
                ontap: () {
                  Get.to(() => const PasswordChangedPopup());
                },
                bgColor:
                    _isFormValid ? AppColor.primaryColor : Color(0xffD2D2D2),
              ),
            ),
            SizedBox(height: h * .02),
          ],
        ),
      ),
    );
  }
}
