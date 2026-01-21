import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/config/app_config.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver({
    // required this.crashlyticsRepository,
    required this.appConfig,
  });

  // final CrashlyticsRepository crashlyticsRepository;
  final IAppConfig appConfig;

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (appConfig.isLogBlocChanges) {
      log('onChange(${bloc.runtimeType}, $change)');
    }
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    if (appConfig.isLogBlocChanges) {
      log('onClose(${bloc.runtimeType})');
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (appConfig.isLogBlocErrors) {
      log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    }
    // crashlyticsRepository.trackFatal(
    //   exception: error,
    //   stackTrace: stackTrace,
    // );
    super.onError(bloc, error, stackTrace);
  }
}
