import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/receipes/components/FilterChipContainer.dart';
import 'package:focofit/views/pages/receipes/components/all_receipes_page.dart';
import 'package:focofit/views/pages/receipes/components/favorites_page.dart';
import 'package:focofit/views/pages/receipes/components/maids_page.dart';
import 'package:focofit/views/pages/receipes/create_receipes/create_receipes_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/app_tab_bar.dart';
import 'package:focofit/views/widgets/app_textfield.dart';
import 'package:focofit/views/widgets/diary_container_tile.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:focofit/views/widgets/search_page.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class ReceipesPage extends StatefulWidget {
  const ReceipesPage({super.key});

  @override
  State<ReceipesPage> createState() => _ReceipesPageState();
}

class _ReceipesPageState extends State<ReceipesPage> {
  int selectedTabIndex = 0;
  final List<Widget> _pages = [AllReceipesPage(), FavoritesPage(), MaidsPage()];

  double calories = 700;
  double prepTime = 90;

  List<String> meals = ["Breakfast", "Lunch", "Dinner", "Snacks"];
  List<String> selectedMeals = ["Lunch"];

  List<String> diets = [
    "Vegetarian",
    "Vegan",
    "Paleo",
    "Low carb",
    "Clean eating",
    "Low carb intake",
  ];
  List<String> selectedDiets = ["Vegetarian"];

  List<String> difficulties = ["Medium", "Easy", "Hard"];
  List<String> selectedDifficulty = ["Easy"];
  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.7,
              minChildSize: 0.5,
              maxChildSize: 0.95,
              builder: (_, controller) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    controller: controller,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: AppText(
                          "Filter by:",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Divider(color: Colors.grey[300]),
                      const SizedBox(height: 16),
                      AppText(
                        "Calories",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            "0 kcal",
                            fontSize: 14,
                            color: AppColor.textColor,
                            fontWeight: FontWeight.w500,
                          ),
                          AppText(
                            "${calories.toInt()} kcal +",
                            fontSize: 14,
                            color: AppColor.textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Slider(
                        value: calories,
                        min: 0,
                        max: 700,
                        activeColor: AppColor.primaryColor,
                        inactiveColor: Colors.grey[300],
                        onChanged: (val) {
                          setModalState(() => calories = val);
                        },
                      ),
                      const SizedBox(height: 10),
                      AppText(
                        "Meals",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textColor,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            meals.map((item) {
                              final isSelected = selectedMeals.contains(item);
                              return FilterChipContainer(
                                label: item,
                                isSelected: isSelected,
                                onTap: () {
                                  setModalState(() {
                                    if (isSelected) {
                                      selectedMeals.remove(item);
                                    } else {
                                      selectedMeals.add(item);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 20),
                      AppText(
                        "Diets",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textColor,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            diets.map((item) {
                              final isSelected = selectedDiets.contains(item);
                              return FilterChipContainer(
                                label: item,
                                isSelected: isSelected,
                                onTap: () {
                                  setModalState(() {
                                    if (isSelected) {
                                      selectedDiets.remove(item);
                                    } else {
                                      selectedDiets.add(item);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                      ),

                      const SizedBox(height: 20),
                      AppText(
                        "Difficulty",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textColor,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children:
                            difficulties.map((item) {
                              final isSelected = selectedDifficulty.contains(
                                item,
                              );
                              return FilterChipContainer(
                                label: item,
                                isSelected: isSelected,
                                onTap: () {
                                  setModalState(() {
                                    selectedDifficulty = [item];
                                  });
                                },
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 20),
                      AppText(
                        "Preparation time",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            "5 min.",
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          AppText(
                            "${prepTime.toInt()} min. +",
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                      Slider(
                        value: prepTime,
                        min: 5,
                        max: 90,
                        activeColor: AppColor.primaryColor,
                        inactiveColor: Colors.grey[300],
                        onChanged: (val) {
                          setModalState(() => prepTime = val);
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          label: "To look for",
                          bgColor: AppColor.primaryColor,
                          ontap: () {
                            Navigator.pop(context);
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            children: [
              HeaderContainer(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 40,
                    right: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/icons/add.png',
                        height: 39,
                        width: 39,
                        color: Colors.transparent,
                      ),
                      Center(
                        child: AppText(
                          'Revenues',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => CreateReceipesPage()),
                        child: Image.asset(
                          'assets/icons/add.png',
                          height: 39,
                          width: 39,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: AppTextfield(
                        onTap: () {
                          Get.to(
                            () => SearchPage(title: 'Revenues', hintText: ''),
                          );
                        },
                        readOnly: true,
                        hint: 'What do you want to prepare?',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            'assets/icons/search2.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        radius: 100,
                        borderColor: AppColor.greyColor.withOpacity(0.10),
                        filledColor: AppColor.greyColor.withOpacity(0.10),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _showFilterBottomSheet(),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColor.greyColor.withOpacity(0.10),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/menu.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
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
                          title: "Maids",
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
          ),
        ),
      ),
    );
  }
}
