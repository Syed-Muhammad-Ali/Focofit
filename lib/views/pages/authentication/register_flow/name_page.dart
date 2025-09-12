import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/authentication/register_flow/gender_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final TextEditingController nameCtr = TextEditingController();
  bool _isFormValid = false;
  @override
  void initState() {
    super.initState();
    nameCtr.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    setState(() {
      _isFormValid = nameCtr.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    nameCtr.dispose();

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
                value: 0.1,
                borderRadius: BorderRadius.circular(10),
                minHeight: 20,
                backgroundColor: Color(0xff999999).withOpacity(.1),
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(width: w * .04),
            AppText(
              '1/10',
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
              'What’s your name?',
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            AppTextfield(ctr: nameCtr, hint: 'Enter your name'),
            const Spacer(),
            SizedBox(
              width: w,
              child: AppButton(
                label: 'Continue',
                ontap: () {
                  Get.to(() => const GenderPage());
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
