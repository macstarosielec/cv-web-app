import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class GradientCard extends StatelessWidget {
  const GradientCard({
    required this.child,
    this.seed = 0,
    super.key,
  });

  final Widget child;
  final int seed;

  @override
  Widget build(BuildContext context) {
    final random = Random(seed);
    final alignment = _randomEdgeAlignment(random);
    final radius = 0.6 + random.nextDouble() * 0.4;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: ColorName.background,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: alignment,
                  radius: radius,
                  colors: [
                    ColorName.accent.withValues(alpha: 0.55),
                    ColorName.accent.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }

  Alignment _randomEdgeAlignment(Random random) {
    const edges = [
      Alignment(-1.2, -0.8),
      Alignment(1.2, -0.6),
      Alignment(-1.0, 0.8),
      Alignment(1.2, 0.6),
      Alignment(-0.8, -1.2),
      Alignment(0.6, 1.2),
    ];
    return edges[random.nextInt(edges.length)];
  }
}
