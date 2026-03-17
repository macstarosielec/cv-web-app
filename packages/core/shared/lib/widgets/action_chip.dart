import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/widgets/fill_painter.dart';

class ActionChip extends StatefulWidget {
  const ActionChip({
    required this.label,
    required this.icon,
    this.onTap,
    this.isLoading = false,
    this.isSelected = false,
    this.iconOnly = false,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isSelected;
  final bool iconOnly;

  @override
  State<ActionChip> createState() => _ActionChipState();
}

class _ActionChipState extends State<ActionChip>
    with TickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final Animation<double> _hoverAnimation;
  late final AnimationController _labelController;
  late final Animation<double> _labelAnimation;

  bool get _stayFilled => widget.isSelected || widget.isLoading;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: _stayFilled ? 1.0 : 0.0,
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
  void didUpdateWidget(ActionChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_stayFilled && !oldWidget.isSelected && !oldWidget.isLoading) {
      unawaited(_hoverController.forward());
    } else if (!_stayFilled && (oldWidget.isSelected || oldWidget.isLoading)) {
      unawaited(_hoverController.reverse());
    }
    if (widget.iconOnly != oldWidget.iconOnly) {
      if (widget.iconOnly) {
        unawaited(_labelController.reverse());
      } else {
        unawaited(_labelController.forward());
      }
    }
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => unawaited(_hoverController.forward()),
        onExit: (_) {
          if (!_stayFilled) unawaited(_hoverController.reverse());
        },
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedBuilder(
            animation: Listenable.merge([_hoverAnimation, _labelAnimation]),
            builder: (context, _) {
              final fontWeight = FontWeight.lerp(
                FontWeight.w500,
                FontWeight.w700,
                _hoverAnimation.value,
              )!;

              return CustomPaint(
                painter: FillPainter(
                  progress: _hoverAnimation.value,
                  backgroundColor: ColorName.surface,
                  fillColor: Theme.of(context).colorScheme.primary,
                ),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  child: Stack(
                    children: [
                      _content(ColorName.textSecondary, fontWeight),
                      ClipRect(
                        clipper: FillClipper(_hoverAnimation.value),
                        child: _content(ColorName.background, fontWeight),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );

  Widget _content(Color color, FontWeight fontWeight) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widget.iconOnly
              ? (_labelAnimation.value > 0 ? 10 : 8)
              : 16,
          vertical: widget.iconOnly ? 6 : 10,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.isLoading)
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: color,
                ),
              )
            else
              Icon(widget.icon, size: AppDimensions.iconSizeDefault, color: color),
            if (_labelAnimation.value > 0) ...[
              const SizedBox(width: AppDimensions.spacingExtraSmall),
              Flexible(
                child: Opacity(
                  opacity: widget.iconOnly ? _labelAnimation.value : 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1,
                        color: color,
                        fontWeight: fontWeight,
                      ),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      );
}
