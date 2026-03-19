abstract class ErrorReportingService {
  Future<void> captureException(Object exception, StackTrace stackTrace);
}
