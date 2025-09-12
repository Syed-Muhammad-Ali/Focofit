import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/diary/diary_page.dart';
import 'package:focofit/views/pages/fasting/fasting_page.dart';
import 'package:focofit/views/pages/receipes/receipes_page.dart';
import 'package:focofit/views/pages/profile/profile_page.dart';
import 'package:focofit/views/widgets/text.dart';

class BnbPage extends StatefulWidget {
  const BnbPage({super.key});

  @override
  State<BnbPage> createState() => _BnbPageState();
}

class _BnbPageState extends State<BnbPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    DiaryPage(),
    FastingPage(),
    ReceipesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            children: [
              Expanded(child: _pages[_currentIndex]),
              Container(
                height: 100,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBottomBar('assets/icons/diary.svg', 'Diary', 0),
                    _buildBottomBar('assets/icons/fasting.svg', 'Fasting', 1),
                    _buildBottomBar('assets/icons/receipes.svg', 'Recipes', 2),
                    _buildBottomBar('assets/icons/profile.svg', 'Profile', 3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(String icon, String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            color:
                _currentIndex == index ? AppColor.primaryColor : Colors.black,
          ),
          AppText(
            title,
            fontSize: 12,
            color:
                _currentIndex == index ? AppColor.primaryColor : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
