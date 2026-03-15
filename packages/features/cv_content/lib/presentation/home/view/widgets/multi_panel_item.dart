import 'dart:async';
import 'dart:math';

import 'package:cv_content/presentation/home/view/widgets/detail_panel_content.dart';
import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:flutter/material.dart';
import 'package:shared/widgets/gradient_card.dart';

class MultiPanelItem extends StatefulWidget {
  const MultiPanelItem({
    required this.width,
    required this.type,
    super.key,
  });

  final double width;
  final DetailPanelType type;

  @override
  State<MultiPanelItem> createState() => _MultiPanelItemState();
}

class _MultiPanelItemState extends State<MultiPanelItem>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;
  late final AnimationController _flipController;
  late final Animation<double> _flipAnimation;

  DetailPanelType? _displayedType;
  DetailPanelType? _nextType;
  bool _seedFlipped = false;

  @override
  void initState() {
    super.initState();
    _displayedType = widget.type;

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    unawaited(_fadeController.forward());
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

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
    if (widget.type != oldWidget.type) {
      _nextType = widget.type;
      unawaited(_flipController.forward());
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _flipController
      ..removeStatusListener(_onFlipComplete)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: SizedBox(
            width: widget.width,
            child: AnimatedBuilder(
              animation: _flipAnimation,
              builder: (context, _) {
                final value = _flipAnimation.value;
                final isFirstHalf = value <= 0.5;
                final type =
                    isFirstHalf ? _displayedType : _nextType;

                if (!isFirstHalf && !_seedFlipped) {
                  _seedFlipped = true;
                } else if (isFirstHalf && _seedFlipped) {
                  _seedFlipped = false;
                }

                final seed = _seedFlipped
                    ? _seedForType(_nextType)
                    : _seedForType(_displayedType);

                final angle =
                    isFirstHalf ? value * pi : (value - 1) * pi;

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
            ),
          ),
        ),
      );

  int _seedForType(DetailPanelType? type) => switch (type) {
        DetailPanelType.projects => 42,
        DetailPanelType.experience => 84,
        DetailPanelType.contact => 126,
        null => 42,
      };
}
