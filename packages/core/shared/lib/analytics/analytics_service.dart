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

}
