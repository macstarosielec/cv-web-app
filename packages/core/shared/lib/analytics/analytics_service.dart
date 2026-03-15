import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  AnalyticsService() : _analytics = FirebaseAnalytics.instance;

  final FirebaseAnalytics _analytics;

  Future<void> logPanelOpened(String panelName) =>
      _analytics.logEvent(
        name: 'panel_opened',
        parameters: {'panel_name': panelName},
      );

  Future<void> logProjectHovered(String projectName) =>
      _analytics.logEvent(
        name: 'project_hovered',
        parameters: {'project_name': projectName},
      );

  Future<void> logExperienceHovered({
    required String title,
    required String company,
  }) =>
      _analytics.logEvent(
        name: 'experience_hovered',
        parameters: {
          'title': title,
          'company': company,
        },
      );

  Future<void> logError({
    required String errorType,
    required String source,
    String? message,
  }) =>
      _analytics.logEvent(
        name: 'app_error',
        parameters: {
          'error_type': errorType,
          'source': source,
          // ignore: use_null_aware_elements, map value type is Object not Object?
          if (message != null) 'message': message,
        },
      );
}
