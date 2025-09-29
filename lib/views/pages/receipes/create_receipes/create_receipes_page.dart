import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/receipes/create_receipes/create_receipes_foco.dart';
import 'package:focofit/views/pages/receipes/edit_receipe/edit_receipe_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class CreateReceipesPage extends StatefulWidget {
  const CreateReceipesPage({super.key});

  @override
  State<CreateReceipesPage> createState() => _CreateReceipesPageState();
}

class _CreateReceipesPageState extends State<CreateReceipesPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          HeaderContainer(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 40, right: 16),
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
                      'Create recipe',
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
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Image.asset('assets/icons/analyze.png'),
                  SizedBox(height: height * 0.05),
                  AppText(
                    "You can register a new recipe manually or use FocoAI, our artificial intelligence, to automatically create a recipe for you.",
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textColor,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.06),
                  SizedBox(
                    width: width,
                    child: AppButton(
                      label: 'Using FocoAI',
                      weight: FontWeight.w500,
                      ontap: () => Get.to(() => CreateReceipesFoco()),
                      bgColor: AppColor.primaryColor,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  SizedBox(
                    width: width,
                    child: AppButton(
                      bgColor: Colors.white,
                      borderColor: AppColor.textColor,
                      useborder: true,
                      txtClr: AppColor.textColor,
                      ontap: () {
                        Get.to(() => EditReceipePage());
                      },
                      label: 'Create manually',
                      isElevation: false,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
