import 'package:auth/presentation/login/view/widgets/login_form.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/utils/app_exception_ui.dart';
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
                  const SizedBox(height: AppDimensions.spacingMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        exception!.icon,
                        size: AppDimensions.iconSizeDefault,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: AppDimensions.spacingExtraSmall),
                      Flexible(
                        child: Text(
                          exception!.message(l10n),
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
