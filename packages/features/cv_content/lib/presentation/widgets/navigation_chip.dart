import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class NavigationChip extends StatefulWidget {
  const NavigationChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.iconOnly = false,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final bool iconOnly;

  @override
  State<NavigationChip> createState() => _NavigationChipState();
}

class _NavigationChipState extends State<NavigationChip>
    with TickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final Animation<double> _hoverAnimation;
  late final AnimationController _labelController;
  late final Animation<double> _labelAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _hoverAnimation = CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    );
    _labelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: widget.iconOnly ? 0.0 : 1.0,
    );
    _labelAnimation = CurvedAnimation(
      parent: _labelController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(NavigationChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
    if (widget.iconOnly != oldWidget.iconOnly) {
      if (widget.iconOnly) {
        _labelController.reverse();
      } else {
        _labelController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => _hoverController.forward(),
        onExit: (_) {
          if (!widget.isSelected) _hoverController.reverse();
        },
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedBuilder(
            animation: Listenable.merge([_hoverAnimation, _labelAnimation]),
            builder: (context, _) => CustomPaint(
              painter: _FillPainter(
                progress: _hoverAnimation.value,
                backgroundColor: ColorName.surface,
                fillColor: ColorName.accent,
              ),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _labelAnimation.value > 0 ? 10 : 8,
                    vertical: 6,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.icon,
                        size: 16,
                        color: ColorName.textSecondary,
                      ),
                      if (_labelAnimation.value > 0) ...[
                        const SizedBox(width: 8),
                        Opacity(
                          opacity: _labelAnimation.value,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              widget.label,
                              style: const TextStyle(
                                fontSize: 18,
                                height: 1,
                                color: ColorName.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
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
