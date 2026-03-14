import 'package:flutter/material.dart';

class StaggerItem extends StatelessWidget {
  const StaggerItem({
    required this.animation,
    required this.child,
    super.key,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: animation,
        builder: (context, c) => Transform.translate(
          offset: Offset(0, 16 * (1 - animation.value)),
          child: Opacity(
            opacity: animation.value,
            child: c,
          ),
        ),
        child: child,
      );
}
