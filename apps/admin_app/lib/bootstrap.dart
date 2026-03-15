import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:admin_app/app/app.dart';
import 'package:admin_app/di/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/analytics/analytics_service.dart';
import 'package:shared/config/app_config.dart';
import 'package:shared/config/firebase_config.dart';
import 'package:shared/observers/app_bloc_observer.dart';

Future<void> bootstrap({required String environment}) async => runZonedGuarded(
  () async {
    WidgetsFlutterBinding.ensureInitialized();

    await configureDependencies(environment: environment);
    await Firebase.initializeApp(
      options: getIt<IFirebaseConfig>().getFirebaseOptions(),
    );

    log('Firebase initialized for environment: $environment');
    log('Firebase app name: ${Firebase.app().name}');
    log('Firebase project ID: ${Firebase.app().options.projectId}');

    final analyticsService = AnalyticsService();
    getIt.registerSingleton<AnalyticsService>(analyticsService);

    FlutterError.onError = (details) {
      unawaited(
        analyticsService.logError(
          errorType: details.exception.runtimeType.toString(),
          source: 'flutter_error',
          message: details.exceptionAsString(),
        ),
      );
    };

    PlatformDispatcher.instance.onError = (exception, stackTrace) {
      unawaited(
        analyticsService.logError(
          errorType: exception.runtimeType.toString(),
          source: 'platform_error',
          message: exception.toString(),
        ),
      );
      return true;
    };

    Bloc.observer = AppBlocObserver(
      appConfig: getIt<IAppConfig>(),
      analyticsService: analyticsService,
    );

    runApp(const App());
  },
  (error, stackTrace) {
    log(error.toString());
    unawaited(
      getIt<AnalyticsService>().logError(
        errorType: error.runtimeType.toString(),
        source: 'zone_error',
        message: error.toString(),
      ),
    );
  },
);
