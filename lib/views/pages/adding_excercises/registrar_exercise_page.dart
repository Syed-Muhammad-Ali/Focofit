import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focofit/views/pages/adding_excercises/describe_exercise/describe_exercise_page.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/search_page.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../widgets/app_tab_bar.dart' show CustomTabBar;
import '../../widgets/diary_container_tile.dart';
import '../../widgets/header_container.dart';
import '../../widgets/text.dart';
import 'registrar_exercise/all_register_exercise_page.dart';
import 'registrar_exercise/favorites_register_exercise_page.dart';
import 'registrar_exercise/servants_register_exercise_page.dart';

class RegistrarExercisePage extends StatefulWidget {
  const RegistrarExercisePage({super.key});

  @override
  State<RegistrarExercisePage> createState() => _RegistrarExercisePageState();
}

class _RegistrarExercisePageState extends State<RegistrarExercisePage> {
  final search = TextEditingController();

  int selectedTabIndex = 0;

  final List<Widget> _pages = [
    AllRegisterExercisePage(),
    FavoritesRegisterExercisePage(),
    ServantsRegisterExercisePage(),
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
                      'Registrar exercise',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => DescribeExercisePage());
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
                SizedBox(height: 12),
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
                Expanded(child: _pages[selectedTabIndex]),
              ],
            ).paddingSymmetric(horizontal: 20),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _buildTab(String title, int tabIndex) {
    bool isSelected = selectedTabIndex == tabIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = tabIndex;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: AppText(
            title,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColor.whiteColor : AppColor.greyColor,
          ),
        ),
      ),
    );
  }
}
