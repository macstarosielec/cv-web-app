import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _InitialState;

  const factory ProfileState.loading() = _LoadingState;

  const factory ProfileState.loaded({
    required Profile profile,
  }) = _LoadedState;

  const factory ProfileState.error({
    required AppException exception,
  }) = _ErrorState;
}
