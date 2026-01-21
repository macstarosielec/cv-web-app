import 'package:cv_app/di/injection.dart';
import 'package:cv_app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/shared.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => AppView();
}

class AppView extends StatelessWidget {
  AppView({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    title: getIt<IAppConfig>().appName,
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    routerDelegate: _appRouter.delegate(
      navigatorObservers: () => [
        AppRouteObserver(),
      ],
    ),
    routeInformationParser: _appRouter.defaultRouteParser(),
  );
}
