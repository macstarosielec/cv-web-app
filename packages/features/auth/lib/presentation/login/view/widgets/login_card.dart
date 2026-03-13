import 'package:auth/presentation/login/view/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key, this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Card(
          color: ColorName.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: ColorName.surfaceBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LoginForm(),
                if (errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: ColorName.accentLight),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      );
}
