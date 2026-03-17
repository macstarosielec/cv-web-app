import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
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
            _iconFor(exception),
            size: 48,
            color: ColorName.textSecondary,
          ),
          const SizedBox(height: AppDimensions.spacingLarge),
          Text(
            _messageFor(l10n, exception),
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

IconData _iconFor(AppException exception) => switch (exception) {
      AuthException() => Icons.lock_outline_rounded,
      NetworkException() => Icons.wifi_off_rounded,
      NotFoundException() => Icons.search_off_rounded,
      PermissionException() => Icons.lock_outline_rounded,
      UnknownException() => Icons.error_outline_rounded,
    };

String _messageFor(AppLocalizations l10n, AppException exception) =>
    switch (exception) {
      AuthException() => l10n.errorAuth,
      NetworkException() => l10n.errorNetwork,
      NotFoundException() => l10n.errorNotFound,
      PermissionException() => l10n.errorPermission,
      UnknownException() => l10n.errorUnknown,
    };
