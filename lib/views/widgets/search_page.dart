import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  final String title;
  final String hintText;
  final search = TextEditingController();
  SearchPage({
    super.key,
    this.title = "Registrar exercise",
    this.hintText = 'What did you eat?',
  });

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
                      title,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/Add.svg',
                    height: 39,
                    width: 39,
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              AppTextfield(
                hint: hintText,
                prefixIcon: Center(
                  child: SvgPicture.asset('assets/icons/search2.svg'),
                ),
                ctr: search,
                radius: 100,
                borderColor: AppColor.greyColor.withOpacity(0.10),
                filledColor: AppColor.greyColor.withOpacity(0.10),
              ),
            ],
          ).paddingSymmetric(horizontal: 20, vertical: 10),
        ],
      ),
    );
  }
}
