import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class MatrixRain extends StatefulWidget {
  const MatrixRain({super.key});

  @override
  State<MatrixRain> createState() => _MatrixRainState();
}

class _MatrixRainState extends State<MatrixRain>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _paintData = _MatrixPaintData();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => CustomPaint(
        painter: _MatrixPainter(data: _paintData),
        size: Size.infinite,
      ),
    );
  }
}

class _MatrixPaintData {
  final Random random = Random(42);
  List<_Column>? columns;
  double lastWidth = 0;
}

class _MatrixPainter extends CustomPainter {
  _MatrixPainter({required this.data});

  final _MatrixPaintData data;

  static const _chars = 'アイウエオカキクケコサシスセソタチツテト'
      'ナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン'
      '0123456789ABCDEF';
  static const _fontSize = 12.0;
  static const _columnSpacing = 20.0;
  static const _speed = 40.0;
  static const _maxOpacity = 0.25;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    if (data.columns == null || data.lastWidth != size.width) {
      data.lastWidth = size.width;
      final columnCount = (size.width / _columnSpacing).floor();
      data.columns =
          List.generate(columnCount, (i) => _Column(data.random));
    }

    final time = DateTime.now().millisecondsSinceEpoch / 1000.0;

    for (var i = 0; i < data.columns!.length; i++) {
      final col = data.columns![i];
      final x = i * _columnSpacing;

      for (var j = 0; j < col.length; j++) {
        final baseY = (time * _speed * col.speed + j * _fontSize) %
            (size.height + col.length * _fontSize);
        final y = baseY - col.length * _fontSize;

        if (y < -_fontSize || y > size.height) continue;

        final fade = j / col.length;
        final opacity = _maxOpacity * fade;

        final charIndex =
            (col.charOffsets[j] + (time * col.charSpeed).floor()) %
                _chars.length;

        final textPainter = TextPainter(
          text: TextSpan(
            text: String.fromCharCode(_chars.codeUnitAt(charIndex)),
            style: TextStyle(
              color: ColorName.accent.withValues(alpha: opacity),
              fontSize: _fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        textPainter.paint(canvas, Offset(x, y));
      }
    }
  }

  @override
  bool shouldRepaint(_MatrixPainter oldDelegate) => true;
}

class _Column {
  _Column(Random random)
      : length = 8 + random.nextInt(16),
        speed = 0.3 + random.nextDouble() * 0.7,
        charSpeed = 1 + random.nextInt(4),
        charOffsets = List.generate(
          24,
          (_) => random.nextInt(_MatrixPainter._chars.length),
        );

  final int length;
  final double speed;
  final int charSpeed;
  final List<int> charOffsets;
}
