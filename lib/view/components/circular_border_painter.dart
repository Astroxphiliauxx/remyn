
import 'dart:math';
import 'package:flutter/material.dart';

class CircularBorderPainter extends CustomPainter {
  final Color color1;
  final Color color2;
  final double arcRatio;

  CircularBorderPainter(this.color1, this.color2, this.arcRatio);

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 8;
    final double radius = (size.width - strokeWidth) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    final Paint paint1 = Paint()
      ..color = color1
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final Paint paint2 = Paint()
      ..color = color2
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -pi / 2, 2 * pi * arcRatio, false, paint1);

    canvas.drawArc(rect, -pi / 2 + 2 * pi * arcRatio, 2 * pi * (1 - arcRatio), false, paint2);
  }

  @override
  bool shouldRepaint(CircularBorderPainter oldDelegate) => true;
}