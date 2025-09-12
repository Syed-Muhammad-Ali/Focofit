import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/get_start/get_started_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  int _currentPage = 0;

  final List<Map<String, String>> _onboardData = [
    {
      'image': 'assets/images/onboard1.png',
      'title': 'Welcome to your fitness journey',
      'desc': 'Log everything you eat and track your\nresults',
    },
    {
      'image': 'assets/images/onboard2.png',
      'title': 'Personalized Plans',
      'desc': 'Get custom meal and workout plans for your\ngoals',
    },
    {
      'image': 'assets/images/onboard3.png',
      'title': 'Track Progress',
      'desc': 'See your improvements and stay\nmotivated',
    },
  ];

  void _nextPage() {
    if (_currentPage < _onboardData.length - 1) {
      setState(() {
        _currentPage++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GetStartedPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final data = _onboardData[_currentPage];
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: AppColor.primaryColor,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: height * .03,
              child: Image.asset(
                data['image']!,
                height: height * 1,
                width: width * 0.8,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: height * .45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/footer.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * .06),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            data['title']!,
                            textAlign: TextAlign.center,
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: height * .03),
                          AppText(
                            data['desc']!,
                            textAlign: TextAlign.center,
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .06),
                    // Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_onboardData.length, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 24 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color:
                                _currentPage == index
                                    ? AppColor.primaryColor
                                    : Colors.grey[300],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: height * .06),
                    // Continue button
                    AppButton(ontap: _nextPage, label: 'Continue'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
