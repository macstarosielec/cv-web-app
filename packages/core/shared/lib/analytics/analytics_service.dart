import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shared/constants/app_constants.dart';

class AnalyticsService {
  AnalyticsService() : _analytics = FirebaseAnalytics.instance;

  final FirebaseAnalytics _analytics;

  Future<void> logPanelOpened(String panelName) =>
      _analytics.logEvent(
        name: AppConstants.eventPanelOpened,
        parameters: {AppConstants.paramPanelName: panelName},
      );

  Future<void> logProjectHovered(String projectName) =>
      _analytics.logEvent(
        name: AppConstants.eventProjectHovered,
        parameters: {AppConstants.paramProjectName: projectName},
      );

  Future<void> logExperienceHovered({
    required String title,
    required String company,
  }) =>
      _analytics.logEvent(
        name: AppConstants.eventExperienceHovered,
        parameters: {
          AppConstants.paramTitle: title,
          AppConstants.paramCompany: company,
        },
      );

  Future<void> logError({
    required String errorType,
    required String source,
    String? message,
  }) =>
      _analytics.logEvent(
        name: AppConstants.eventAppError,
        parameters: {
          AppConstants.paramErrorType: errorType,
          AppConstants.paramSource: source,
          // ignore: use_null_aware_elements, map value type is Object not Object?
          if (message != null) AppConstants.paramMessage: message,
        },
      );
}
