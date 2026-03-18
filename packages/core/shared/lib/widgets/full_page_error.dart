import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/utils/app_exception_ui.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

class FullPageError extends StatelessWidget {
  const FullPageError({
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            exception.icon,
            size: 48,
            color: ColorName.textSecondary,
          ),
          const SizedBox(height: AppDimensions.spacingLarge),
          Text(
            exception.message(l10n),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorName.textSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 28),
          shared.ActionChip(
            label: l10n.retry,
            icon: Icons.refresh,
            onTap: onRetry,
          ),
        ],
      ),
    );
  }
}
