import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/bnb/bnb_page.dart';
import 'package:focofit/views/pages/diary/result_correction_page.dart';
import 'package:focofit/views/pages/setting/report_bug/report_bug_bottom_sheet.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:get/get.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/diary_container_tile.dart';
import '../../../widgets/header_container.dart';
import '../../../widgets/text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final title = TextEditingController();
  final desc = TextEditingController();
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Column(
        children: [
          HeaderContainer(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 40, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      'assets/icons/Back.png',
                      height: 39,
                      width: 39,
                    ),
                  ),
                  Center(
                    child: AppText(
                      'Register exercise',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/Add.svg',
                    height: 39,
                    width: 39,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                DiaryContainerTile(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔹 Title + icons row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      "Corrida resistência",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isFavorite = !isFavorite;
                                        });
                                      },

                                      child: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 22,
                                        color:
                                            isFavorite
                                                ? Colors.red
                                                : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),

                      // 🔹 Bottom section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Calories
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Calorie expenditure",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "0",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Divider line
                          Container(
                            width: 1,
                            height: 30,
                            color: Colors.grey[300],
                          ),

                          // Intensity
                          Column(
                            children: [
                              Text(
                                "Intensity",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                "Alta",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      'Exercise duration',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textColor,
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppTextfield(ctr: title, hint: '35'),
                    ),
                    SizedBox(width: Get.width * 0.04),
                    Expanded(
                      flex: 3,
                      child: AppTextfield(ctr: title, hint: 'minutes'),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/alert.png'),
                    SizedBox(width: 8),
                    AppText(
                      'Found an error? ',
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ReportBugBottomSheet());
                      },
                      child: AppText(
                        'Report',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        ontap: () {
                          Get.to(() => ResultCorrectionPage());
                        },
                        label: 'To correct',
                        txtClr: AppColor.textColor,
                        borderColor: AppColor.blackColor,
                        bgColor: AppColor.whiteColor,
                      ),
                    ),
                    SizedBox(width: Get.width * 0.01),
                    Expanded(
                      child: AppButton(
                        ontap: () {
                          Get.to(() => BnbPage());
                        },
                        label: 'Register',
                        bgColor: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ).paddingSymmetric(vertical: 20, horizontal: 20),
          ),
        ],
      ),
    );
  }
}
