import 'package:auth/presentation/login/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

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

  void _submit() => context.read<AuthCubit>().signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sign In',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: ColorName.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: ColorName.textPrimary),
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: ColorName.textSecondary),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorName.surfaceBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorName.accent),
              ),
            ),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(color: ColorName.textPrimary),
            decoration: const InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: ColorName.textSecondary),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorName.surfaceBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorName.accent),
              ),
            ),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorName.accent,
              foregroundColor: ColorName.textPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const RoundedRectangleBorder(),
            ),
            child: const Text('Sign In'),
          ),
        ],
      );
}
