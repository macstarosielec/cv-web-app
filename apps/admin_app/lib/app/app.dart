import 'dart:async';

import 'package:admin_app/di/injection.dart';
import 'package:admin_app/router/router.dart';
import 'package:admin_content/admin_content.dart';
import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<AuthCubit>()..checkAuthStatus(),
        child: const AppView(),
      );
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) =>
      BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            authenticated: () => unawaited(
                  _appRouter.replaceAll([const DashboardRoute()]),
                ),
            unauthenticated: () => unawaited(
                  _appRouter.replaceAll([const LoginRoute()]),
                ),
            error: (_) {},
          );
        },
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          title: getIt<IAppConfig>().appName,
          theme: AppTheme.dark,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.dark,
          routerDelegate: _appRouter.delegate(
            navigatorObservers: () => [
              AppRouteObserver(),
            ],
          ),
          routeInformationParser: _appRouter.defaultRouteParser(),
        ),
      );
}
