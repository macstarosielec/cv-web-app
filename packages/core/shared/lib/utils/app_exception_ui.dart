import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/l10n/l10n.dart';

extension AppExceptionUI on AppException {
  IconData get icon => switch (this) {
        AuthException() => Icons.lock_outline_rounded,
        NetworkException() => Icons.wifi_off_rounded,
        NotFoundException() => Icons.search_off_rounded,
        PermissionException() => Icons.lock_outline_rounded,
        UnknownException() => Icons.error_outline_rounded,
      };

  String message(AppLocalizations l10n) => switch (this) {
        AuthException() => l10n.errorAuth,
        NetworkException() => l10n.errorNetwork,
        NotFoundException() => l10n.errorNotFound,
        PermissionException() => l10n.errorPermission,
        UnknownException() => l10n.errorUnknown,
      };
}
