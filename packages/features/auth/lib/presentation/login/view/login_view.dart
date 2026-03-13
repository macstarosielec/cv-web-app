import 'package:auth/presentation/login/cubit/auth_cubit.dart';
import 'package:auth/presentation/login/cubit/auth_state.dart';
import 'package:auth/presentation/login/view/widgets/login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorName.background,
        body: Center(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) => state.when(
              initial: () => const LoginCard(),
              loading: () =>
                  const CircularProgressIndicator(color: ColorName.accent),
              authenticated: () =>
                  const CircularProgressIndicator(color: ColorName.accent),
              unauthenticated: () => const LoginCard(),
              error: (message) => LoginCard(errorMessage: message),
            ),
          ),
        ),
      );
}
