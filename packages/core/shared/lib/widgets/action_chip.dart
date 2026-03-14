import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class ActionChip extends StatefulWidget {
  const ActionChip({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  State<ActionChip> createState() => _ActionChipState();
}

class _ActionChipState extends State<ActionChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final Animation<double> _hoverAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: widget.isLoading ? 1.0 : 0.0,
    );
    _hoverAnimation = CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    );
  }

  @override
  void didUpdateWidget(ActionChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !oldWidget.isLoading) {
      unawaited(_hoverController.forward());
    }
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => unawaited(_hoverController.forward()),
        onExit: (_) {
          if (!widget.isLoading) unawaited(_hoverController.reverse());
        },
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedBuilder(
            animation: _hoverAnimation,
            builder: (context, _) => CustomPaint(
              painter: _FillPainter(
                progress: _hoverAnimation.value,
                backgroundColor: ColorName.surface,
                fillColor: Theme.of(context).colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.isLoading)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ColorName.textPrimary,
                        ),
                      )
                    else
                      Icon(
                        widget.icon,
                        size: 16,
                        color: ColorName.textSecondary,
                      ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        widget.label,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1,
                          color: ColorName.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _FillPainter extends CustomPainter {
  _FillPainter({
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
  bool shouldRepaint(_FillPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.fillColor != fillColor;
}
