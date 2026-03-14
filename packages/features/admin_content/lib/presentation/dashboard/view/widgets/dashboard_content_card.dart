import 'package:flutter/material.dart';
import 'package:shared/widgets/gradient_card.dart';

class DashboardContentCard extends StatelessWidget {
  const DashboardContentCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Expanded(
        child: GradientCard(
          seed: 42,
          child: child,
        ),
      );
}
