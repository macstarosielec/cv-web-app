import 'dart:async';
import 'dart:math';

import 'package:cv_content/presentation/home/view/widgets/detail_panel_content.dart';
import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:flutter/material.dart';
import 'package:shared/widgets/gradient_card.dart';

class DetailPanel extends StatefulWidget {
  const DetailPanel({
    required this.type,
    required this.animationProgress,
    super.key,
  });

  final DetailPanelType? type;
  final double animationProgress;

  @override
  State<DetailPanel> createState() => _DetailPanelState();
}

class _DetailPanelState extends State<DetailPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flipController;
  late final Animation<double> _flipAnimation;
  DetailPanelType? _displayedType;
  DetailPanelType? _nextType;
  bool _seedFlipped = false;

  @override
  void initState() {
    super.initState();
    _displayedType = widget.type;
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
      });
    }
  }

  @override
  void didUpdateWidget(DetailPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.type != oldWidget.type && widget.type != null) {
      if (_displayedType == null) {
        setState(() {
          _displayedType = widget.type;
        });
      } else if (widget.type != _displayedType) {
        _nextType = widget.type;
        unawaited(_flipController.forward());
      }
    }
  }

  @override
  void dispose() {
    _flipController
      ..removeStatusListener(_onFlipComplete)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animationProgress < 1) {
      return GradientCard(
        seed: _seedForType(_displayedType),
        child: const SizedBox.shrink(),
      );
    }

    return AnimatedBuilder(
      animation: _flipAnimation,
      builder: (context, _) {
        final value = _flipAnimation.value;
        final isFirstHalf = value <= 0.5;
        final type = isFirstHalf ? _displayedType : _nextType;

        // Only switch the seed once the card is edge-on (invisible)
        if (!isFirstHalf && !_seedFlipped) {
          _seedFlipped = true;
        } else if (isFirstHalf && _seedFlipped) {
          _seedFlipped = false;
        }

        final seed = _seedFlipped
            ? _seedForType(_nextType)
            : _seedForType(_displayedType);

        final angle = isFirstHalf
            ? value * pi
            : (value - 1) * pi;

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
  }

  int _seedForType(DetailPanelType? type) => switch (type) {
        DetailPanelType.projects => 42,
        DetailPanelType.experience => 84,
        DetailPanelType.contact => 126,
        null => 42,
      };

}
