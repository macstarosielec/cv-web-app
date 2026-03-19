import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';

/// Displays location and timezone as a compact row with icons,
/// styled consistently with the contact panel.
class LocationInfoRow extends StatelessWidget {
  const LocationInfoRow({this.location, this.timezone, super.key});

  final String? location;
  final String? timezone;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final accentColor = Theme.of(context).colorScheme.primary;

    return Row(
      children: [
        if (location != null) ...[
          Icon(
            Icons.location_on_outlined,
            size: AppDimensions.iconSizeMedium,
            color: accentColor,
          ),
          const SizedBox(width: AppDimensions.spacingTiny),
          Flexible(
            child: Text(
              location!,
              style: textTheme.bodyMedium?.copyWith(
                color: ColorName.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
        if (location != null && timezone != null)
          const SizedBox(width: AppDimensions.spacingMedium),
        if (timezone != null) ...[
          Icon(
            Icons.schedule,
            size: AppDimensions.iconSizeMedium,
            color: accentColor,
          ),
          const SizedBox(width: AppDimensions.spacingTiny),
          Flexible(
            child: Text(
              timezone!,
              style: textTheme.bodyMedium?.copyWith(
                color: ColorName.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }
}
