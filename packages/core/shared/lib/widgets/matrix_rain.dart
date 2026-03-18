import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MatrixRain extends StatefulWidget {
  const MatrixRain({super.key});

  @override
  State<MatrixRain> createState() => _MatrixRainState();
}

class _MatrixRainState extends State<MatrixRain>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final _paintData = _MatrixPaintData();

  // Offset so every instance starts at a different visual position.
  late final double _timeOffset =
      DateTime.now().millisecondsSinceEpoch / 1000.0 % 10000;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    unawaited(_ticker.start());
  }

  void _onTick(Duration elapsed) {
    _paintData.time = _timeOffset + elapsed.inMilliseconds / 1000.0;
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    return RepaintBoundary(
      child: CustomPaint(
        painter: _MatrixPainter(data: _paintData, accentColor: accent),
        size: Size.infinite,
      ),
    );
  }
}

class _MatrixPaintData extends ChangeNotifier {
  final Random random = Random(42);
  List<_Column>? columns;
  double _time = 0;

  double get time => _time;
  set time(double value) {
    _time = value;
    notifyListeners();
  }
}

class _MatrixPainter extends CustomPainter {
  _MatrixPainter({required this.data, required this.accentColor})
      : super(repaint: data);

  final _MatrixPaintData data;
  final Color accentColor;

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

    final columnCount = (size.width / _columnSpacing).floor();
    if (columnCount <= 0) return;

    final existing = data.columns;
    if (existing == null) {
      data.columns = List.generate(columnCount, (_) => _Column(data.random));
    } else if (columnCount > existing.length) {
      // Width grew — keep existing columns, append new ones.
      data.columns = [
        ...existing,
        for (var i = existing.length; i < columnCount; i++)
          _Column(data.random),
      ];
    } else if (columnCount < existing.length) {
      // Width shrank — trim from the right, keep the rest intact.
      data.columns = existing.sublist(0, columnCount);
    }

    final time = data.time;

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

        TextPainter(
          text: TextSpan(
            text: String.fromCharCode(_chars.codeUnitAt(charIndex)),
            style: TextStyle(
              color: accentColor.withValues(alpha: opacity),
              fontSize: _fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          textDirection: TextDirection.ltr,
        )
          ..layout()
          ..paint(canvas, Offset(x, y));
      }
    }
  }

  @override
  bool shouldRepaint(_MatrixPainter oldDelegate) => false;
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
