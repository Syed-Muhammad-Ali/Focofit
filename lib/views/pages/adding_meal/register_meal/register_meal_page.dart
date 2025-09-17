// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focofit/views/pages/adding_meal/register_meal/all_register_meal_page.dart';
import 'package:focofit/views/pages/adding_meal/register_meal/favorites_register_meal_page.dart';
import 'package:focofit/views/pages/adding_meal/register_meal/servants_register_meal_page.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/search_page.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../widgets/app_tab_bar.dart';
import '../../../widgets/diary_container_tile.dart';
import '../../../widgets/header_container.dart';
import '../../../widgets/text.dart';
import '../describe_meal/describe_meal_page.dart';

class RegisterMealPage extends StatefulWidget {
  RegisterMealPage({super.key});

  @override
  State<RegisterMealPage> createState() => RegisterMealPageState();
}

class RegisterMealPageState extends State<RegisterMealPage> {
  final search = TextEditingController();

  int selectedTabIndex = 0;

  final List<Widget> _pages = [
    AllRegisterMealPage(),
    FavoritesRegisterMealPage(),
    ServantsRegisterMealPage(),
  ];

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
                      'Register Meal',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => DescribeMealPage());
                    },
                    child: SvgPicture.asset(
                      'assets/icons/Add.svg',
                      height: 39,
                      width: 39,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * .04),

                Row(
                  children: [
                    ActionCard(
                      iconPath: 'assets/icons/scan.png',
                      label: 'Scan',
                      onTap: () {
                        print("Scan tapped");
                      },
                    ),
                    const SizedBox(width: 10),
                    ActionCard(
                      iconPath: 'assets/icons/describe.png',
                      label: 'Describe',
                      onTap: () {
                        print("Search tapped");
                      },
                    ),
                    const SizedBox(width: 10),
                    ActionCard(
                      iconPath: 'assets/icons/upload_photo.png',
                      label: 'Upload photo',
                      onTap: () {
                        print("Recipe tapped");
                      },
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                AppTextfield(
                  onTap: () {
                    Get.to(() => SearchPage());
                  },
                  readOnly: true,
                  hint: 'What did you eat?',
                  prefixIcon: Center(
                    child: SvgPicture.asset('assets/icons/search2.svg'),
                  ),
                  ctr: search,
                  radius: 100,
                  borderColor: AppColor.greyColor.withOpacity(0.10),
                  filledColor: AppColor.greyColor.withOpacity(0.10),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DiaryContainerTile(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTabBar(
                            title: "All",
                            isSelected: selectedTabIndex == 0,
                            onTap: () => setState(() => selectedTabIndex = 0),
                          ),
                        ),
                        Expanded(
                          child: CustomTabBar(
                            title: "Favorites",
                            isSelected: selectedTabIndex == 1,
                            onTap: () => setState(() => selectedTabIndex = 1),
                          ),
                        ),
                        Expanded(
                          child: CustomTabBar(
                            title: "Servants",
                            isSelected: selectedTabIndex == 2,
                            onTap: () => setState(() => selectedTabIndex = 2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(child: _pages[selectedTabIndex]),
              ],
            ).paddingSymmetric(horizontal: 20),
          ),
        ],
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: MediaQuery.sizeOf(context).height * .08,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                iconPath,
                width: 28,
                height: 28,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.error, color: Colors.red, size: 24),
                  );
                },
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppText(
                  label,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
