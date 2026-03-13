import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _InitialState;

  const factory AuthState.loading() = _LoadingState;

  const factory AuthState.authenticated() = _AuthenticatedState;

  const factory AuthState.unauthenticated() = _UnauthenticatedState;

  const factory AuthState.error({
    required String message,
  }) = _ErrorState;
}
