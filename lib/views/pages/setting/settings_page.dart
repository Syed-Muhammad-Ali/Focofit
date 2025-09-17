import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focofit/utils/image_picker_service.dart';
import 'package:focofit/views/pages/setting/Calorie%20goal/Calorie_goal_page.dart';
import 'package:focofit/views/pages/setting/activity_level/activity_level_page.dart';
import 'package:focofit/views/pages/setting/application_language/application_language_page.dart';
import 'package:focofit/views/pages/setting/change_email/change_email_bottom_sheet.dart'
    show ChangeEmailBottomSheet;
import 'package:focofit/views/pages/setting/change_name/change_name_bottom_sheet.dart';
import 'package:focofit/views/pages/setting/current_weight/current_weight_bottom_sheet.dart';
import 'package:focofit/views/pages/setting/gender/gender_page.dart';
import 'package:focofit/views/pages/setting/logout/logout_bottom_sheet.dart';
import 'package:focofit/views/pages/setting/macro_goal/macro_goal_page.dart';
import 'package:focofit/views/pages/setting/my_diet/my_diet_page.dart';
import 'package:focofit/views/pages/setting/report_bug/report_bug_bottom_sheet.dart';
import 'package:focofit/views/pages/setting/target_weight/target_weight_bottom_sheet.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/colors.dart';

import '../../widgets/diary_container_tile.dart';
import '../../widgets/header_container.dart';
import 'change_passward/change_password_bottom_sheet.dart';
import 'current_age/current_age_bottom_sheet.dart';
import 'current_height/current_height_bottom_sheet.dart'
    show CurrenHeightBottomSheet;
import 'medical_conditions/medical_conditions_page.dart';

class SettingsPage extends StatelessWidget {
  final imagePickerService = Get.put(ImagePickerService());
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainer(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 40),
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
                        'Settings',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textColor,
                      ),
                    ),
                    Image.asset(
                      'assets/icons/Back.png',
                      height: 39,
                      width: 39,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.04),

            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    bottomSheet();
                  },
                  child: Obx(() {
                    final picked = imagePickerService.pickedImage.value;
                    if (picked != null) {
                      return Container(
                        width: 186,
                        height: 186,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.greyColor),
                          image: DecorationImage(
                            image: FileImage(File(picked.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 75,
                            backgroundImage: const AssetImage(
                              'assets/images/profile.png',
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: SvgPicture.asset('assets/icons/old.svg'),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                ),

                SizedBox(height: Get.height * 0.02),
                AppText(
                  'Weslei Vicentini',
                  color: AppColor.blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: Get.height * 0.04),
                Divider(),
                SizedBox(height: Get.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      'Access data',
                      color: AppColor.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),

                DiaryContainerTile(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SettingsRow(
                        onTap:
                            () => ChangeEmailBottomSheet()
                                .showLogMealBottomSheet(context),
                        icon: 'assets/icons/email.svg',
                        title: 'Email',
                        desc: 'loremipsum@gmail.com',
                      ),

                      Divider(),
                      SettingsRow(
                        onTap:
                            () => ChangePasswordBottomSheet()
                                .showLogMealBottomSheet(context),
                        icon: 'assets/icons/email.svg',
                        title: 'Password',
                        desc: '***********',
                      ),

                      //.   Personal data
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      'Personal data',
                      color: AppColor.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                DiaryContainerTile(
                  child: Column(
                    children: [
                      SettingsRow(
                        onTap:
                            () => ChangeNameBottomSheet()
                                .showLogMealBottomSheet(context),
                        icon: 'assets/icons/idade.svg',
                        title: 'Name',
                        desc: 'Weslei Vicentini',
                      ),
                      Divider(),
                      SettingsRow(
                        onTap:
                            () => CurrentAgeBottomSheet()
                                .showLogMealBottomSheet(context),
                        icon: 'assets/icons/idade-2.svg',
                        title: 'Age',
                        desc: '22 years',
                      ),
                      Divider(),
                      SettingsRow(
                        onTap:
                            () => CurrenHeightBottomSheet()
                                .showLogMealBottomSheet(context),
                        icon: 'assets/icons/icon pente.svg',
                        title: 'Height',
                        desc: '153 cm',
                      ),
                      Divider(),
                      SettingsRow(
                        onTap:
                            () => CurrentWeightBottomSheet()
                                .showLogMealBottomSheet(context),
                        icon: 'assets/icons/meta atual.svg',
                        title: 'Current weight',
                        desc: '67 kg',
                      ),
                      Divider(),
                      SettingsRow(
                        onTap:
                            () => TargetWeightBottomSheet()
                                .showLogMealBottomSheet(context),
                        icon: 'assets/icons/peso meta.svg',
                        title: 'Current weight',
                        desc: '60 kg',
                      ),
                      Divider(),
                      SettingsRow(
                        onTap: () {
                          Get.to(() => GenderPage());
                        },
                        icon: 'assets/icons/icon.svg',
                        title: 'Gender',
                        desc: 'Male',
                      ),
                      Divider(),
                      SettingsRow(
                        onTap: () {
                          Get.to(() => ActivityLevelPage());
                        },
                        icon: 'assets/icons/nivel de atividade.svg',
                        title: 'Activity level',
                        desc: 'Very active',
                      ),
                      Divider(),
                      SettingsRow(
                        onTap: () {
                          Get.to(() => MyDietPage());
                        },
                        icon: 'assets/icons/minha dieta.svg',
                        title: 'My diet',
                        desc: 'Vegetarian',
                      ),
                      Divider(),
                      SettingsRow(
                        onTap: () {
                          Get.to(() => CalorieGoal());
                        },
                        icon: 'assets/icons/meta de calorias.svg',
                        title: 'Calorie goal',
                      ),
                      Divider(),
                      SettingsRow(
                        onTap: () {
                          Get.to(() => MacroGoalPage());
                        },
                        icon: 'assets/icons/macronutrientes.svg',
                        title: 'Macronutrient target',
                      ),
                      Divider(),
                      SettingsRow(
                        onTap: () {
                          Get.to(() => MedicalConditionsPage());
                        },
                        icon: 'assets/icons/condicoes medicas.svg',
                        title: 'Medical conditions',
                      ),
                      //.    Information
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(
                      'Information',
                      color: AppColor.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                DiaryContainerTile(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SettingsRow(
                        onTap: () {
                          Get.to(() => ApplicationLanguagePage());
                        },
                        icon: 'assets/icons/Language.svg',
                        title: 'Application language',
                      ),

                      Divider(),
                      SettingsRow(
                        icon: 'assets/icons/politicas.svg',
                        title: 'Privacy policies',
                      ),
                      Divider(),
                      SettingsRow(
                        icon: 'assets/icons/termos.svg',
                        title: 'Terms of service',
                      ),
                      Divider(),
                      SettingsRow(
                        icon: 'assets/icons/suporte 2.svg',
                        title: 'Contact support',
                      ),
                      Divider(),
                      SettingsRow(
                        onTap:
                            () => ReportBugBottomSheet().showLogMealBottomSheet(
                              context,
                            ),
                        icon: 'assets/icons/erro report.svg',
                        title: 'Report a bug',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.06),
              ],
            ).paddingSymmetric(horizontal: 20),
            AppButton(
              ontap: () => LogoutBottomSheet().showLogMealBottomSheet(context),
              label: 'Log out of account',
              bgColor: AppColor.pinColor,
            ),
            SizedBox(height: Get.height * 0.06),
          ],
        ),
      ),
    );
  }

  Future<dynamic> bottomSheet() {
    return Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () {
                Get.back();
                imagePickerService.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () {
                Get.back();
                imagePickerService.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsRow extends StatelessWidget {
  final String icon;
  final String title;
  final String? desc; // make nullable
  final Function()? onTap;

  const SettingsRow({
    super.key,
    required this.icon,
    required this.title,
    this.desc, // optional now
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          SizedBox(width: Get.width * 0.04),

          // Title + optional desc
          SizedBox(
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  title,
                  color: AppColor.blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),

                // Show desc only if provided
                if (desc != null && desc!.isNotEmpty)
                  AppText(
                    desc!,
                    color: AppColor.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
              ],
            ),
          ),

          const Spacer(),

          SvgPicture.asset(
            'assets/icons/forwardArrow.svg',
            height: 16,
            width: 18,
          ),
        ],
      ),
    );
  }
}
