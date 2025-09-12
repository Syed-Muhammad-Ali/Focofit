import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/authentication/change_pass_page.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class RecoverPassPage extends StatefulWidget {
  const RecoverPassPage({super.key});

  @override
  State<RecoverPassPage> createState() => _RecoverPassPageState();
}

class _RecoverPassPageState extends State<RecoverPassPage> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  void _onCodeChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    // Check if all fields are filled
    bool allFilled = _controllers.every(
      (controller) => controller.text.length == 1,
    );
    if (allFilled) {
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.to(() => const ChangePassPage()); // Replace with your actual page
      });
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < 4; i++) {
      _controllers[i].dispose();
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.sizeOf(context).height;
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
                'Enter the code we sent to your email below so we can continue with the password change.',
                fontSize: 16,
                color: Colors.black,
              ),
              SizedBox(height: h * .04),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            _focusNodes[index].hasFocus
                                ? AppColor.primaryColor
                                : Colors.grey[300]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) => _onCodeChanged(value, index),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: h * .04),

              Center(
                child: AppText(
                  'Please wait 00:59 to request a new code',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),

              // Resend code link
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: AppText(
                    'Resend code',
                    fontSize: 16,
                    color: Color(0xffD2D2D2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
