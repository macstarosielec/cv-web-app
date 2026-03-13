import 'package:auth/presentation/login/cubit/auth_cubit.dart';
import 'package:auth/presentation/login/view/login_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = useMemoized(() => GetIt.instance<AuthCubit>());

    return BlocProvider.value(
      value: authCubit,
      child: const LoginView(),
    );
  }
}
