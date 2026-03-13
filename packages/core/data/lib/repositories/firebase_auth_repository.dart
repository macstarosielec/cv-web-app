import 'package:data/datasources/firebase_auth_datasource.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._datasource);

  final FirebaseAuthDatasource _datasource;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _datasource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  @override
  Future<void> signOut() => _datasource.signOut();

  @override
  Stream<bool> get authStateChanges => _datasource.authStateChanges;

  @override
  bool get isAuthenticated => _datasource.isAuthenticated;
}
