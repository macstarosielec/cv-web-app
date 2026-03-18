abstract class IAppConfig {
  String get environment;
  String get appName;
  bool get isLogBlocChanges;
  bool get isLogBlocErrors;
  bool get alwaysAnimateEntrance;
  String get sentryDsn;
}
