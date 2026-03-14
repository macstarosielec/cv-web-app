import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class DotLoader extends StatefulWidget {
  const DotLoader({super.key});

  static const _dotCount = 5;
  static const _dotSize = 8.0;
  static const _gap = 8.0;

  @override
  State<DotLoader> createState() => _DotLoaderState();
}

class _DotLoaderState extends State<DotLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(DotLoader._dotCount, (i) {
          final delay = i * 0.125;
          final t = (_controller.value - delay) % 1.0;
          final active = t > 0 && t < 0.25;

          return Padding(
            padding: EdgeInsets.only(
              left: i > 0 ? DotLoader._gap : 0,
            ),
            child: Container(
              width: DotLoader._dotSize,
              height: DotLoader._dotSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? accent : Colors.transparent,
                border: Border.all(
                  color: active
                      ? accent
                      : ColorName.textPrimary.withValues(alpha: 0.15),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
