import 'package:flutter/material.dart';

class AnimatedFormItem extends StatelessWidget {
  const AnimatedFormItem({
    required this.animation,
    required this.child,
    super.key,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: animation.drive(
            Tween(begin: const Offset(0, 0.1), end: Offset.zero),
          ),
          child: child,
        ),
      );
}
