import 'package:auth/presentation/login/cubit/auth_cubit.dart';
import 'package:auth/presentation/login/cubit/auth_state.dart';
import 'package:auth/presentation/login/view/widgets/login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/widgets/dot_loader.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) => state.when(
              initial: () => const LoginCard(),
              loading: () => const LoginCard(isLoading: true),
              authenticated: () => const DotLoader(),
              unauthenticated: () => const LoginCard(),
              error: (message) => LoginCard(errorMessage: message),
            ),
          ),
        ),
      );
}
