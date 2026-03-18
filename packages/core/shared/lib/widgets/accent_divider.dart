import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';

class AccentDivider extends StatelessWidget {
  const AccentDivider({super.key, this.vertical = false});

  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final color =
        Theme.of(context).colorScheme.primary.withValues(alpha: 0.2);

    if (vertical) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingLarge),
        child: VerticalDivider(color: color, thickness: 1, width: 1),
      );
    }

    return Divider(color: color, thickness: 1);
  }
}
