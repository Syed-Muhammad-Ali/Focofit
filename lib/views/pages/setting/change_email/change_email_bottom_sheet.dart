import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class ChangeEmailBottomSheet extends GetxController {
  final email = TextEditingController();
  final cemail = TextEditingController();
  RxString current = 'email'.obs;
  RxString otpCode = ''.obs;

  void showLogMealBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: GetBuilder<ChangeEmailBottomSheet>(
              init: this,
              builder:
                  (controller) => Column(
                    children: [
                      // Handle bar
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 12),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Title
                      AppText(
                        'Change Email',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: const Divider(),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      // Text fields
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:
                            current.value == 'email'
                                ? Column(
                                  children: [
                                    AppTextfield(
                                      title: 'New email',
                                      titleSize: 16,
                                      titleColor: AppColor.textColor,
                                      ctr: email,
                                      onchanged: (val) {
                                        update();
                                      },
                                    ),
                                    AppTextfield(
                                      title: 'Confirm email',
                                      titleSize: 16,
                                      titleColor: AppColor.textColor,
                                      ctr: cemail,
                                      onchanged: (val) {
                                        update(); // Manually trigger UI update
                                      },
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    AppButton(
                                      label: 'Continue',
                                      ontap:
                                          (email.text.isNotEmpty &&
                                                  cemail.text.isNotEmpty)
                                              ? () {
                                                current.value = 'pass';
                                                update();
                                              }
                                              : null,
                                      bgColor:
                                          (email.text.isNotEmpty &&
                                                  cemail.text.isNotEmpty)
                                              ? AppColor.primaryColor
                                              : Colors.transparent,
                                    ),
                                  ],
                                )
                                : current.value == 'pass'
                                ? Column(
                                  children: [
                                    AppText(
                                      textAlign: TextAlign.center,
                                      'For security reasons, enter the code we sent to your email below.',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.textColor,
                                    ),
                                    SizedBox(height: Get.height * 0.02),
                                    OtpInput(
                                      onChanged: (code) {
                                        otpCode.value = code;
                                        update();
                                      },

                                      onCompleted: (code) {
                                        otpCode.value = code;
                                        update();
                                      },
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    AppButton(
                                      label: 'Continue',
                                      ontap:
                                          (otpCode.value.length == 4)
                                              ? () {
                                                current.value = 'check';
                                                update();
                                              }
                                              : null,
                                      bgColor:
                                          (otpCode.value.length == 4)
                                              ? AppColor.primaryColor
                                              : Colors.transparent,
                                    ),
                                  ],
                                )
                                : current.value == 'check'
                                ? Column(
                                  children: [
                                    Image.asset('assets/images/check.png'),
                                    SizedBox(height: Get.height * 0.01),
                                    AppText(
                                      'Your email has been changed successfully!',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.textColor,
                                    ),
                                    SizedBox(height: Get.height * 0.02),
                                    AppButton(
                                      label: 'Continue',
                                      ontap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                )
                                : SizedBox(),
                      ),
                      SizedBox(height: Get.height * 0.01),

                      Spacer(),
                    ],
                  ),
            ),
          ),
    );
  }
}

class OtpInput extends StatefulWidget {
  final int length;
  final void Function(String) onCompleted;
  final void Function(String)? onChanged;
  const OtpInput({
    super.key,
    this.length = 4,
    required this.onCompleted,
    this.onChanged,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.length, (_) => TextEditingController());
    focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < widget.length - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    }
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }

    String code = controllers.map((c) => c.text).join();

    // 🔥 trigger onChanged
    widget.onChanged?.call(code);

    if (code.length == widget.length) {
      widget.onCompleted(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.orange, width: 2),
              ),
            ),
            onChanged: (value) => _onChanged(value, index),
          ),
        );
      }),
    );
  }
}
