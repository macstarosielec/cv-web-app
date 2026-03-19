import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared/analytics/analytics_service.dart';
import 'package:shared/config/app_config.dart';
import 'package:shared/config/firebase_config.dart';
import 'package:shared/error_reporting/error_reporting_service.dart';
import 'package:shared/observers/app_bloc_observer.dart';

Future<void> sharedBootstrap({
  required String environment,
  required Future<void> Function({required String environment})
      configureDependencies,
  required GetIt getIt,
  required Widget app,
}) async {
  await configureDependencies(environment: environment);

  final appConfig = getIt<IAppConfig>();
  final sentryDsn = appConfig.sentryDsn;

  Future<void> runMainApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: getIt<IFirebaseConfig>().getFirebaseOptions(),
    );

    log('Firebase initialized for environment: $environment');
    log('Firebase app name: ${Firebase.app().name}');
    log('Firebase project ID: ${Firebase.app().options.projectId}');

    final analyticsService = AnalyticsService();
    getIt.registerSingleton<AnalyticsService>(analyticsService);

    final errorReportingService = getIt<ErrorReportingService>();

    FlutterError.onError = (details) {
      unawaited(
        errorReportingService.captureException(
          details.exception,
          details.stack ?? StackTrace.current,
        ),
      );
    };

    PlatformDispatcher.instance.onError = (exception, stackTrace) {
      unawaited(
        errorReportingService.captureException(exception, stackTrace),
      );
      return true;
    };

    Bloc.observer = AppBlocObserver(
      appConfig: appConfig,
      errorReportingService: errorReportingService,
    );

    runApp(app);
  }

  if (sentryDsn.isNotEmpty) {
    await SentryFlutter.init(
      (options) {
        options
          ..dsn = sentryDsn
          ..environment = environment;
      },
      appRunner: runMainApp,
    );
  } else {
    await runZonedGuarded(
      () async {
        await runMainApp();
      },
      (error, stackTrace) {
        log(error.toString());
      },
    );
  }
}
