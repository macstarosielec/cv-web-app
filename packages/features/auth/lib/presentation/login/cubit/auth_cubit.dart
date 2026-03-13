import 'package:auth/presentation/login/cubit/auth_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState.initial());

  final AuthRepository _authRepository;

  void checkAuthStatus() => _authRepository.isAuthenticated
      ? emit(const AuthState.authenticated())
      : emit(const AuthState.unauthenticated());

  Future<void> signIn(String email, String password) async {
    emit(const AuthState.loading());
    try {
      await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(const AuthState.authenticated());
    } on Exception catch (e) {
      emit(AuthState.error(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(const AuthState.unauthenticated());
  }
}
