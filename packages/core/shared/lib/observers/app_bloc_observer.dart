import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/analytics/analytics_service.dart';
import 'package:shared/config/app_config.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver({
    required this.appConfig,
    required this.analyticsService,
  });

  final IAppConfig appConfig;
  final AnalyticsService analyticsService;

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
    unawaited(
      analyticsService.logError(
        errorType: error.runtimeType.toString(),
        source: 'bloc:${bloc.runtimeType}',
        message: error.toString(),
      ),
    );
    super.onError(bloc, error, stackTrace);
  }
}
