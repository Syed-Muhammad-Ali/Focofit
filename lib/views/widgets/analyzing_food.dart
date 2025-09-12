import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/diary/food_recorded_page.dart';
import 'package:focofit/views/widgets/text.dart';
import 'dart:async';

class AnalyzingFoodPage extends StatefulWidget {
  const AnalyzingFoodPage({super.key});

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
        // Navigate to next page when complete
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    FoodRecordedPage(), // Replace with your actual next page
          ),
        );
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.transparent,
          ),
        ),
        title: AppText(
          'Describe meal',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(),
            Spacer(),
            Image.asset('assets/icons/analyze.png'),
            // Progress indicator
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

            // Progress text
            AppText(
              _progressMessages[_currentStep < _progressMessages.length
                  ? _currentStep
                  : _progressMessages.length - 1],
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),

            Spacer(),

            // Progress percentage
          ],
        ),
      ),
    );
  }
}
