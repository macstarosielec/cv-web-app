import 'dart:async';
import 'dart:math';

import 'package:cv_content/presentation/home/view/widgets/detail_panel_content.dart';
import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:flutter/material.dart';
import 'package:shared/widgets/gradient_card.dart';

class MultiPanelItem extends StatefulWidget {
  const MultiPanelItem({
    required this.targetWidth,
    required this.gap,
    required this.type,
    required this.isClosing,
    required this.onClosed,
    super.key,
  });

  final double targetWidth;
  final double gap;
  final DetailPanelType type;
  final bool isClosing;
  final VoidCallback onClosed;

  @override
  State<MultiPanelItem> createState() => _MultiPanelItemState();
}

class _MultiPanelItemState extends State<MultiPanelItem>
    with TickerProviderStateMixin {
  late final AnimationController _sizeController;
  late final Animation<double> _sizeAnimation;
  late final AnimationController _flipController;
  late final Animation<double> _flipAnimation;

  DetailPanelType? _displayedType;
  DetailPanelType? _nextType;
  bool _seedFlipped = false;

  // Cached values at close start so the animation doesn't jump.
  double? _closingWidth;
  double? _closingGap;

  @override
  void initState() {
    super.initState();
    _displayedType = widget.type;

    _sizeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _sizeAnimation = CurvedAnimation(
      parent: _sizeController,
      curve: Curves.easeOut,
    );
    unawaited(_sizeController.forward());
    _sizeController.addStatusListener(_onSizeStatus);

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flipAnimation = CurvedAnimation(
      parent: _flipController,
      curve: Curves.easeInOut,
    );
    _flipController.addStatusListener(_onFlipComplete);
  }

  void _onSizeStatus(AnimationStatus status) {
    if (status == AnimationStatus.dismissed && widget.isClosing) {
      widget.onClosed();
    }
  }

  void _onFlipComplete(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _displayedType = _nextType;
        _flipController.reset();
        _seedFlipped = false;
      });
    }
  }

  @override
  void didUpdateWidget(MultiPanelItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isClosing && !oldWidget.isClosing) {
      _closingWidth = oldWidget.targetWidth;
      _closingGap = oldWidget.gap;
      unawaited(_sizeController.reverse());
    } else if (!widget.isClosing && oldWidget.isClosing) {
      // Cancel close (rapid toggle)
      _closingWidth = null;
      _closingGap = null;
      unawaited(_sizeController.forward());
    }
    if (widget.type != oldWidget.type && !widget.isClosing) {
      _nextType = widget.type;
      unawaited(_flipController.forward());
    }
  }

  @override
  void dispose() {
    _sizeController
      ..removeStatusListener(_onSizeStatus)
      ..dispose();
    _flipController
      ..removeStatusListener(_onFlipComplete)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _sizeAnimation,
        builder: (context, _) {
          final progress = _sizeAnimation.value;
          final effectiveWidth = _closingWidth ?? widget.targetWidth;
          final effectiveGap = _closingGap ?? widget.gap;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: effectiveGap * progress),
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    width: effectiveWidth,
                    child: _buildFlipContent(),
                  ),
                ),
              ),
            ],
          );
        },
      );

  Widget _buildFlipContent() => AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, _) {
          final value = _flipAnimation.value;
          final isFirstHalf = value <= 0.5;
          final type = isFirstHalf ? _displayedType : _nextType;

          if (!isFirstHalf && !_seedFlipped) {
            _seedFlipped = true;
          } else if (isFirstHalf && _seedFlipped) {
            _seedFlipped = false;
          }

          final seed = _seedFlipped
              ? _seedForType(_nextType)
              : _seedForType(_displayedType);

          final angle = isFirstHalf ? value * pi : (value - 1) * pi;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: GradientCard(
              seed: seed,
              child: type != null
                  ? DetailPanelContent(type: type)
                  : const SizedBox.shrink(),
            ),
          );
        },
      );

  int _seedForType(DetailPanelType? type) =>
      type?.gradientSeed ?? DetailPanelType.projects.gradientSeed;
}
