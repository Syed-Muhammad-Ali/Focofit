// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/diary/food_recorded_page.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:focofit/views/widgets/text.dart';

class AnalyzingFoodPage extends StatefulWidget {
  final String title;
  final VoidCallback? onComplete;
  const AnalyzingFoodPage({
    super.key,
    this.title = "Describe meal",
    this.onComplete,
  });

  @override
  State<AnalyzingFoodPage> createState() => _AnalyzingFoodPageState();
}

class _AnalyzingFoodPageState extends State<AnalyzingFoodPage> {
  double _progress = 0.0;
  int _currentStep = 0;
  Timer? _timer;

  final List<String> _progressMessages = [
    'Identifying food...',
    'Analyzing nutrients...',
    'Preparing meal planner...',
    'Calculating calories...',
    'Finalizing results...',
    'Almost done...',
  ];

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    const duration = Duration(
      milliseconds: 500,
    ); // 3 seconds total / 6 steps = 500ms per step

    _timer = Timer.periodic(duration, (timer) {
      if (_currentStep < _progressMessages.length) {
        setState(() {
          _progress = (_currentStep + 1) / _progressMessages.length;
          _currentStep++;
        });
      } else {
        timer.cancel();

        if (widget.onComplete != null) {
          widget.onComplete!();
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FoodRecordedPage()),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Image.asset(
                    'assets/icons/Back.png',
                    height: 39,
                    width: 39,
                    color: Colors.transparent,
                  ),
                  Center(
                    child: AppText(
                      widget.title,
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
          Expanded(
            child: Column(
              children: [
                Spacer(),
                Image.asset('assets/icons/analyze.png'),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: LinearProgressIndicator(
                    // value: _progress,
                    backgroundColor: Colors.grey[200],
                    color: AppColor.primaryColor,
                    minHeight: 8,
                  ),
                ),
                SizedBox(height: 24),
                AppText(
                  _progressMessages[_currentStep < _progressMessages.length
                      ? _currentStep
                      : _progressMessages.length - 1],
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
