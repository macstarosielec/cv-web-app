import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';

class EmailRow extends StatelessWidget {
  const EmailRow({
    required this.accentColor,
    required this.cells,
    super.key,
  });

  final Color accentColor;
  final List<Widget> cells;

  @override
  Widget build(BuildContext context) => FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.email_outlined,
              size: AppDimensions.iconSizeMedium,
              color: accentColor,
            ),
            const SizedBox(width: 12),
            ...cells,
          ],
        ),
      );
}
