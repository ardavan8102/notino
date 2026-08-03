import 'package:flutter/material.dart';
import 'dart:math' as math;

class DoubleFadeBorderPainter extends CustomPainter {

  final Color color;

  const DoubleFadeBorderPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(16),
    );

    paint.shader = SweepGradient(
      center: Alignment.center,
      startAngle: -math.pi / 5,
      colors: [
        color.withValues(alpha: .3),
        color.withValues(alpha: 0),
        color.withValues(alpha: .8),
        color.withValues(alpha: 0),
        color.withValues(alpha: .8),
      ],
      stops: [0.0, 0.3, 0.4, 0.7, 0.8],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
