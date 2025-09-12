import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/text.dart';

class FastingProgressPage extends StatefulWidget {
  final int fastingHours;
  final int eatingHours;
  final DateTime startTime;
  final DateTime endTime;

  const FastingProgressPage({
    super.key,
    required this.fastingHours,
    required this.eatingHours,
    required this.startTime,
    required this.endTime,
  });

  @override
  State<FastingProgressPage> createState() => _FastingProgressPageState();
}

class _FastingProgressPageState extends State<FastingProgressPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  late Timer _timer;
  DateTime _currentTime = DateTime.now();
  Duration _elapsedTime = Duration.zero;
  Duration _exceededTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _startTimer();
    _animationController.forward();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
        _elapsedTime = _currentTime.difference(widget.startTime);

        // Calculate exceeded time (time beyond the fasting period)
        if (_elapsedTime.inSeconds > (widget.fastingHours * 3600)) {
          _exceededTime = Duration(
            seconds: _elapsedTime.inSeconds - (widget.fastingHours * 3600),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.textColor),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const AppText(
          'Fasting in progress',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColor.textColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Circular Progress Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Circular Progress Indicator
                  SizedBox(
                    height: 200,
                    child: AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        double progress =
                            _elapsedTime.inSeconds /
                            (widget.fastingHours * 3600);
                        progress = progress.clamp(0.0, 1.0);

                        return CircularPercentIndicator(
                          animationDuration: 1000,
                          linearGradient: const LinearGradient(
                            colors: [
                              AppColor.primaryColor,
                              AppColor.primaryColor,
                            ],
                          ),
                          backgroundColor: Colors.grey[300]!,
                          animation: true,
                          restartAnimation: true,
                          rotateLinearGradient: true,
                          fillColor: Colors.transparent,
                          circularStrokeCap: CircularStrokeCap.round,
                          widgetIndicator: Container(
                            margin: const EdgeInsets.only(right: 40),
                            child: const Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          radius: 120,
                          lineWidth: 40,
                          backgroundWidth: 40,
                          percent: progress,
                          curve: Curves.easeIn,
                          startAngle:
                              0, // Start from top center (12 o'clock position)
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const AppText(
                                'Elapsed time',
                                fontSize: 14,
                                color: Color(0xFF999999),
                              ),
                              const SizedBox(height: 8),
                              AppText(
                                _formatDuration(_elapsedTime),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColor.textColor,
                              ),
                              const SizedBox(height: 8),
                              const AppText(
                                'Time exceeded',
                                fontSize: 14,
                                color: Color(0xFF999999),
                              ),
                              const SizedBox(height: 4),
                              AppText(
                                '+${_formatDuration(_exceededTime)}',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.textColor,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Divider
                  Container(height: 1, color: Colors.grey[300]),
                  const SizedBox(height: 24),
                  // Start and End times
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Start time
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                            'Start at',
                            fontSize: 14,
                            color: Color(0xFF999999),
                          ),
                          const SizedBox(height: 4),
                          AppText(
                            _formatTime(widget.startTime),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                          const SizedBox(height: 4),
                          AppText(
                            _formatDate(widget.startTime),
                            fontSize: 12,
                            color: Color(0xFF999999),
                          ),
                        ],
                      ),
                      // End time
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const AppText(
                            'End at',
                            fontSize: 14,
                            color: Color(0xFF999999),
                          ),
                          const SizedBox(height: 4),
                          AppText(
                            _formatTime(widget.endTime),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                          const SizedBox(height: 4),
                          AppText(
                            _formatDate(widget.endTime),
                            fontSize: 12,
                            color: Color(0xFF999999),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly.isAtSameMomentAs(today)) {
      return 'Today (${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')})';
    } else if (dateOnly.isAtSameMomentAs(tomorrow)) {
      return 'Tomorrow (${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')})';
    } else {
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
    }
  }
}
