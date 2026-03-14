import 'package:flutter/material.dart';

class FillPainter extends CustomPainter {
  FillPainter({
    required this.progress,
    required this.backgroundColor,
    required this.fillColor,
  });

  final double progress;
  final Color backgroundColor;
  final Color fillColor;

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = backgroundColor;
    canvas.drawRect(Offset.zero & size, bgPaint);

    if (progress <= 0) return;

    final fillPaint = Paint()..color = fillColor;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width * progress, size.height),
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(FillPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.fillColor != fillColor;
}
