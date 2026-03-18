import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SpinningBracketIcon extends StatefulWidget {
  const SpinningBracketIcon({this.size = 120, super.key});

  final double size;

  @override
  State<SpinningBracketIcon> createState() => _SpinningBracketIconState();
}

class _SpinningBracketIconState extends State<SpinningBracketIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    unawaited(_controller.repeat());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final angle = _controller.value * 2 * pi;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: child,
          );
        },
        child: CustomPaint(
          size: Size.square(widget.size),
          painter: _BracketPainter(
            accentColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
}

class _BracketPainter extends CustomPainter {
  _BracketPainter({required this.accentColor});

  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 128;
    final cx = size.width / 2;
    final cy = size.height / 2;

    final bracketPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..strokeWidth = 3 * s
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Left bracket <
    final leftPath = Path()
      ..moveTo(cx - 16 * s, cy - 36 * s)
      ..lineTo(cx - 40 * s, cy)
      ..lineTo(cx - 16 * s, cy + 36 * s);
    canvas.drawPath(leftPath, bracketPaint);

    // Right bracket >
    final rightPath = Path()
      ..moveTo(cx + 16 * s, cy - 36 * s)
      ..lineTo(cx + 40 * s, cy)
      ..lineTo(cx + 16 * s, cy + 36 * s);
    canvas.drawPath(rightPath, bracketPaint);

    // Center dot
    final dotPaint = Paint()..color = accentColor.withValues(alpha: 0.3);
    canvas.drawCircle(Offset(cx, cy), 8 * s, dotPaint);

    // Top tick
    final tickPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.25)
      ..strokeWidth = 2 * s
      ..strokeCap = StrokeCap.round;
    canvas
      // Top tick
      ..drawLine(
        Offset(cx, cy - 50 * s),
        Offset(cx, cy - 42 * s),
        tickPaint,
      )
      // Bottom tick
      ..drawLine(
        Offset(cx, cy + 42 * s),
        Offset(cx, cy + 50 * s),
        tickPaint,
      );
  }

  @override
  bool shouldRepaint(_BracketPainter oldDelegate) =>
      accentColor != oldDelegate.accentColor;
}
