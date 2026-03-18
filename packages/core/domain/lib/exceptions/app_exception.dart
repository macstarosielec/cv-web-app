sealed class AppException implements Exception {
  const AppException({required this.originalError, this.stackTrace});

  final Object originalError;
  final StackTrace? stackTrace;
}

class NetworkException extends AppException {
  const NetworkException({required super.originalError, super.stackTrace});
}

class NotFoundException extends AppException {
  const NotFoundException({required super.originalError, super.stackTrace});
}

class PermissionException extends AppException {
  const PermissionException({required super.originalError, super.stackTrace});
}

class AuthException extends AppException {
  const AuthException({required super.originalError, super.stackTrace});
}

class UnknownException extends AppException {
  const UnknownException({required super.originalError, super.stackTrace});
}
