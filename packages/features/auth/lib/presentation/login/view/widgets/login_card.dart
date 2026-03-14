import 'package:auth/presentation/login/view/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/widgets/gradient_card.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
    this.errorMessage,
    this.isLoading = false,
  });

  final String? errorMessage;
  final bool isLoading;

  static const double cardWidth = 400;
  static const double cardHeight = 380;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: GradientCard(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Admin Panel',
                  style:
                      Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: ColorName.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorName.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                LoginForm(isLoading: isLoading),
                if (errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      );
}
