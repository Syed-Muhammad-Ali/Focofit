import 'package:flutter/material.dart';
import 'dart:math';

import 'package:focofit/views/widgets/text.dart';

class SemiCircularProgressBar extends StatelessWidget {
  final int remainingCalories;
  final int totalCalories;

  const SemiCircularProgressBar({
    super.key,
    required this.remainingCalories,
    required this.totalCalories,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SemiCircularPainter(
        progress: remainingCalories / totalCalories,
      ),
      child: SizedBox(
        width: 200,
        height: 80,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  '$remainingCalories',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                AppText(
                  'Remaining calories',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SemiCircularPainter extends CustomPainter {
  final double progress;

  _SemiCircularPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 15.0;
    final radius = (size.width / 2) - strokeWidth;
    final center = Offset(size.width / 2, size.height);

    // Start at ~195°, sweep ~165°, to create droop on both ends
    final startAngle = pi - .26;
    final fullSweep = pi + 0.5;
    final sweepAngle = fullSweep * progress;

    final backgroundPaint =
        Paint()
          ..color = Colors.grey.shade300
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    final gradientPaint =
        Paint()
          ..shader = SweepGradient(
            startAngle: pi,
            endAngle: 2 * pi,
            colors: [
              const Color(0xffFD8900).withOpacity(.50),
              const Color(0xffFD8900),
            ],
          ).createShader(Rect.fromCircle(center: center, radius: radius))
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    // Draw background arc with both ends curved and dropped
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      fullSweep,
      false,
      backgroundPaint,
    );

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
