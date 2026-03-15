import 'package:auth/presentation/login/view/widgets/login_form.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/gradient_card.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
    this.exception,
    this.isLoading = false,
  });

  final AppException? exception;
  final bool isLoading;

  static const double cardWidth = 400;
  static const double cardHeight = 380;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: cardWidth,
          minHeight: cardHeight,
        ),
        child: GradientCard(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.adminPanel,
                  style:
                      Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: ColorName.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.signInToContinue,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorName.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                LoginForm(isLoading: isLoading),
                if (exception != null) ...[
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _iconFor(exception!),
                        size: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          _messageFor(l10n, exception!),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
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
