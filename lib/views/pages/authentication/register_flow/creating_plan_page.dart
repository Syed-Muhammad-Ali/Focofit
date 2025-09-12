import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/bnb/bnb_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/text.dart';
import 'dart:async';

import 'package:get/get.dart';

class CreatingPlanPage extends StatefulWidget {
  const CreatingPlanPage({super.key});

  @override
  State<CreatingPlanPage> createState() => _CreatingPlanPageState();
}

class _CreatingPlanPageState extends State<CreatingPlanPage> {
  double _progress = 0.0;
  int _percentage = 0;
  Timer? _timer;
  int _currentStep = 0;
  bool _isComplete = false;

  // Custom percentage increments
  final List<int> _percentageSteps = [
    0,
    1,
    2,
    4,
    8,
    9,
    12,
    15,
    18,
    22,
    26,
    30,
    35,
    40,
    45,
    50,
    55,
    60,
    65,
    70,
    75,
    80,
    85,
    90,
    95,
    100,
  ];

  // Status messages that change as progress increases
  final List<String> _statusMessages = [
    "Analysing the diet followed...",
    "Calculating your BMI...",
    "Creating personalized recommendations...",
    "Optimizing meal plans...",
    "Finalizing your profile...",
    "Almost done...",
  ];

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    const duration = Duration(
      milliseconds: 200,
    ); // 5 seconds total / 25 steps = 200ms per step

    _timer = Timer.periodic(duration, (timer) {
      if (_currentStep < _percentageSteps.length) {
        setState(() {
          _percentage = _percentageSteps[_currentStep];
          _progress = _percentage / 100;
          _currentStep++;

          // Check if progress is complete
          if (_percentage == 100) {
            _isComplete = true;
          }
        });
      } else {
        timer.cancel();

        print('Progress complete: $_percentage%');
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
    final double h = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: h * 0.15),
            // Top text
            AppText(
              'We are personalising',
              fontSize: 28,
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            AppText(
              'recommendations for you.',
              fontSize: 28,
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: h * 0.02),
            AppText(
              'Please wait...',
              fontSize: 18,
              color: Colors.grey[600],
              textAlign: TextAlign.center,
            ),
            SizedBox(height: h * 0.1),

            // Circular progress indicator
            Center(
              child: SizedBox(
                width: 600,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular progress
                    CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      padding: EdgeInsets.zero,
                      strokeAlign: 15,
                      value: _progress,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColor.primaryColor,
                      ),
                    ),
                    // Percentage text
                    AppText(
                      '$_percentage%',
                      fontSize: 32,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.04),

            if (!_isComplete)
              AppText(
                _getStatusMessage(),
                fontSize: 16,
                color: Colors.grey[600],
                textAlign: TextAlign.center,
              ),

            const Spacer(),

            if (!_isComplete)
              Align(
                alignment: Alignment.center,
                child: AppText(
                  'This will only take a few moments.',
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),

            if (_isComplete) ...[
              SizedBox(height: h * 0.05),
              AppButton(
                label: 'Let\'s go!',
                ontap: () {
                  Get.to(() => const BnbPage());
                },
                bgColor: AppColor.primaryColor,
              ),
            ],

            SizedBox(height: h * 0.05),
          ],
        ),
      ),
    );
  }

  String _getStatusMessage() {
    if (_percentage < 20) return _statusMessages[0];
    if (_percentage < 40) return _statusMessages[1];
    if (_percentage < 60) return _statusMessages[2];
    if (_percentage < 80) return _statusMessages[3];
    if (_percentage < 95) return _statusMessages[4];
    return _statusMessages[5];
  }
}
