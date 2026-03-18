import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/utils/app_exception_ui.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

class SectionError extends StatelessWidget {
  const SectionError({
    required this.exception,
    required this.onRetry,
    super.key,
  });

  final AppException exception;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              exception.icon,
              size: 32,
              color: ColorName.textSecondary,
            ),
            const SizedBox(height: AppDimensions.spacingMedium),
            Text(
              exception.message(l10n),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorName.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            shared.ActionChip(
              label: l10n.retry,
              icon: Icons.refresh,
              onTap: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
