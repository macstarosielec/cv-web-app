import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseAuthDatasource {
  FirebaseAuthDatasource(this._auth);

  final FirebaseAuth _auth;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> signOut() => _auth.signOut();

  Stream<bool> get authStateChanges =>
      _auth.authStateChanges().map((user) => user != null);

  bool get isAuthenticated => _auth.currentUser != null;
}
