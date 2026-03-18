import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';

class TagChip extends StatelessWidget {
  const TagChip({
    required this.label,
    this.onRemove,
    super.key,
  });

  final String label;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: const BoxDecoration(color: ColorName.surfaceLight),
        child: onRemove != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorName.textPrimary,
                        ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: onRemove,
                    child: const Icon(
                      Icons.close,
                      size: AppDimensions.iconSizeSmall,
                      color: ColorName.textMuted,
                    ),
                  ),
                ],
              )
            : Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorName.textSecondary,
                    ),
              ),
      );
}
