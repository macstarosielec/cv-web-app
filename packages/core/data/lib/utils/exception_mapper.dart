import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';

AppException mapException(Object error, StackTrace stackTrace) {
  if (error is FirebaseException) {
    return switch (error.code) {
      'unavailable' ||
      'deadline-exceeded' ||
      'resource-exhausted' =>
        NetworkException(originalError: error, stackTrace: stackTrace),
      'not-found' =>
        NotFoundException(originalError: error, stackTrace: stackTrace),
      'permission-denied' ||
      'unauthenticated' =>
        PermissionException(originalError: error, stackTrace: stackTrace),
      _ => UnknownException(originalError: error, stackTrace: stackTrace),
    };
  }
  return UnknownException(originalError: error, stackTrace: stackTrace);
}
