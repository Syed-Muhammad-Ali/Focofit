import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/receipes/all_receipes_page.dart';
import 'package:focofit/views/pages/receipes/favorites_page.dart';
import 'package:focofit/views/pages/receipes/maids_page.dart';
import 'package:focofit/views/widgets/diary_container_tile.dart';
import 'package:focofit/views/widgets/header_container.dart';
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
                        onTap: () => Get.back(),
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DiaryContainerTile(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Row(
                    children: [
                      Expanded(child: _buildTab('All', 0)),
                      Expanded(child: _buildTab('Favorites', 1)),
                      Expanded(child: _buildTab('Maids', 2)),
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
