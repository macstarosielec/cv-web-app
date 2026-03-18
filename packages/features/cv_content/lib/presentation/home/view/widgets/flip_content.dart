import 'dart:math';

import 'package:cv_content/presentation/home/view/widgets/detail_panel_content.dart';
import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:flutter/material.dart';
import 'package:shared/widgets/gradient_card.dart';

class FlipContent extends StatelessWidget {
  const FlipContent({
    required this.flipAnimation,
    required this.displayedType,
    required this.nextType,
    required this.seedFlipped,
    super.key,
  });

  final Animation<double> flipAnimation;
  final DetailPanelType? displayedType;
  final DetailPanelType? nextType;
  final bool seedFlipped;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: flipAnimation,
        builder: (context, _) {
          final value = flipAnimation.value;
          final isFirstHalf = value <= 0.5;
          final type = isFirstHalf ? displayedType : nextType;

          final seed = seedFlipped
              ? _seedForType(nextType)
              : _seedForType(displayedType);

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
