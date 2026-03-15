import 'package:data/datasources/firebase_auth_datasource.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._datasource);

  final FirebaseAuthDatasource _datasource;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _datasource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e, st) {
      switch (e.code) {
        case 'wrong-password' ||
             'user-not-found' ||
             'invalid-credential' ||
             'invalid-email' ||
             'user-disabled':
          throw AuthException(originalError: e, stackTrace: st);
        case 'too-many-requests':
          throw NetworkException(originalError: e, stackTrace: st);
        default:
          throw UnknownException(originalError: e, stackTrace: st);
      }
    } on Exception catch (e, st) {
      throw UnknownException(originalError: e, stackTrace: st);
    }
  }

  @override
  Future<void> signOut() => _datasource.signOut();

  @override
  Stream<bool> get authStateChanges => _datasource.authStateChanges;

  @override
  bool get isAuthenticated => _datasource.isAuthenticated;
}
