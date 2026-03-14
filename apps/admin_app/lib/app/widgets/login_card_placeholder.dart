import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class LoginCardPlaceholder extends StatelessWidget {
  const LoginCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) => Padding(
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
          ],
        ),
      );
}
