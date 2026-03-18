import 'dart:async';

import 'package:auth/presentation/login/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/action_chip.dart' as shared;
import 'package:shared/widgets/app_input_decoration.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _obscurePassword = true;
  bool _submitted = false;

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _sanitize(String input) =>
      input.replaceAll(RegExp(r'[<>"{}|\\^`]'), '').trim();

  String? _validateEmail(String? value) {
    final l10n = AppLocalizations.of(context);
    if (value == null || value.trim().isEmpty) return l10n.emailRequired;
    if (!_emailRegex.hasMatch(value.trim())) return l10n.enterValidEmail;
    return null;
  }

  String? _validatePassword(String? value) {
    final l10n = AppLocalizations.of(context);
    if (value == null || value.isEmpty) return l10n.passwordRequired;
    return null;
  }

  void _submit() {
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;

    final email = _sanitize(_emailController.text);
    unawaited(context.read<AuthCubit>().signIn(email, _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Form(
        key: _formKey,
        autovalidateMode: _submitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              enableSuggestions: false,
              style: const TextStyle(color: ColorName.textPrimary),
              validator: _validateEmail,
              decoration: appInputDecoration(
                context: context,
                label: l10n.email,
                prefixIcon: Icons.email_outlined,
              ),
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: AppDimensions.spacingMedium),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              autocorrect: false,
              enableSuggestions: false,
              style: const TextStyle(color: ColorName.textPrimary),
              validator: _validatePassword,
              decoration: appInputDecoration(
                context: context,
                label: l10n.password,
                prefixIcon: Icons.lock_outlined,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: ColorName.textSecondary,
                    size: AppDimensions.iconSizeDefault,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: AppDimensions.spacingLarge),
            Center(
              child: shared.ActionChip(
                label: l10n.signIn,
                icon: Icons.login,
                isLoading: widget.isLoading && _submitted,
                onTap: widget.isLoading ? null : _submit,
              ),
            ),
          ],
        ),
      );
  }
}
