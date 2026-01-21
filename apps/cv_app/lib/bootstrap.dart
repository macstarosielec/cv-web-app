import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:cv_app/app/app.dart';
import 'package:cv_app/di/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/config/app_config.dart';
import 'package:shared/observers/app_bloc_observer.dart';

Future<void> bootstrap({required String environment}) async => runZonedGuarded(
  () async {
    WidgetsFlutterBinding.ensureInitialized();

    await configureDependencies(environment: environment);
    await Firebase.initializeApp(
      options: getIt<IAppConfig>().getFirebaseOptions(),
    );

    log('Firebase initialized for environment: $environment');
    log('Firebase app name: ${Firebase.app().name}');
    log('Firebase project ID: ${Firebase.app().options.projectId}');

    FlutterError.onError = (details) {
      // final exception = details.exception;
      // final stackTrace = details.stack;
      // crashlyticsRepository.trackFatal(
      //   exception: exception,
      //   stackTrace: stackTrace,
      // );
    };

    PlatformDispatcher.instance.onError = (exception, stackTrace) {
      // crashlyticsRepository.trackFatal(
      //   exception: exception,
      //   stackTrace: stackTrace,
      // );
      return true;
    };

    Bloc.observer = AppBlocObserver(
      // crashlyticsRepository: crashlyticsRepository,
      appConfig: getIt<IAppConfig>(),
    );

    runApp(const App());
  },
  (error, stackTrace) {
    log(error.toString());
    // getIt
    //     .get<CrashlyticsRepository>()
    //     .trackFatal(exception: error, stackTrace: stackTrace);
  },
);
