import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared/error_reporting/error_reporting_service.dart';

@LazySingleton(as: ErrorReportingService)
class SentryErrorReportingService implements ErrorReportingService {
  @override
  Future<void> captureException(
    Object exception,
    StackTrace stackTrace,
  ) =>
      Sentry.captureException(exception, stackTrace: stackTrace);
}
