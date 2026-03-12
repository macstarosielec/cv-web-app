import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class NavigationChip extends StatefulWidget {
  const NavigationChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<NavigationChip> createState() => _NavigationChipState();
}

class _NavigationChipState extends State<NavigationChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final Animation<double> _hoverAnimation;

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
  }

  @override
  void dispose() {
    _hoverController.dispose();
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
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _hoverController.forward(),
      onExit: (_) {
        if (!widget.isSelected) _hoverController.reverse();
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _hoverAnimation,
          builder: (context, child) {
            final fillProgress = _hoverAnimation.value;

            return CustomPaint(
              painter: _FillPainter(
                progress: fillProgress,
                backgroundColor: ColorName.surface,
                fillColor: ColorName.accent,
              ),
              child: child,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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
    );
  }
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
