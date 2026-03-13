import 'package:auth/presentation/login/cubit/auth_cubit.dart';
import 'package:auth/presentation/login/cubit/auth_state.dart';
import 'package:auth/presentation/login/view/widgets/login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static Widget _buildContent(BuildContext context, AuthState state) =>
      state.when(
        initial: _buildLoginCard,
        loading: _buildLoading,
        authenticated: _buildAuthenticated,
        unauthenticated: _buildLoginCard,
        error: _buildError,
      );

  static Widget _buildLoginCard() => const LoginCard();

  static Widget _buildLoading() =>
      const CircularProgressIndicator(color: ColorName.accent);

  static Widget _buildAuthenticated() => const Text(
        'Authenticated',
        style: TextStyle(color: ColorName.textPrimary),
      );

  static Widget _buildError(String message) => LoginCard(errorMessage: message);

  @override
  Widget build(BuildContext context) => const Scaffold(
        backgroundColor: ColorName.background,
        body: Center(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: _buildContent,
          ),
        ),
      );
}
