import 'package:admin_app/app/admin_auth_shell.dart';
import 'package:admin_app/di/injection.dart';
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

class AppView extends StatelessWidget {
  const AppView({super.key});

  static const _accent = Color(0xFF2563EB);
  static const _accentLight = Color(0xFF3B82F6);
  static const _accentDark = Color(0xFF1D4ED8);

  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: getIt<IAppConfig>().appName,
        theme: AppTheme.dark(
          accent: _accent,
          accentLight: _accentLight,
          accentDark: _accentDark,
        ),
        darkTheme: AppTheme.dark(
          accent: _accent,
          accentLight: _accentLight,
          accentDark: _accentDark,
        ),
        themeMode: ThemeMode.dark,
        home: const AdminAuthShell(),
      );
}
