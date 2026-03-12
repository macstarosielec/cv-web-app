import 'package:cv_app/di/injection.dart';
import 'package:cv_app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const AppView();
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
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
  );
}
