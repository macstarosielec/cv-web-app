import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@dev
@LazySingleton(as: AuthRepository)
class MockAuthRepository implements AuthRepository {
  @override
  bool get isAuthenticated => true;

  @override
  Stream<bool> get authStateChanges => Stream.value(true);

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {}

  @override
  Future<void> signOut() async {}
}
