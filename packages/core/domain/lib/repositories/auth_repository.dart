abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Stream<bool> get authStateChanges;
  bool get isAuthenticated;
}
