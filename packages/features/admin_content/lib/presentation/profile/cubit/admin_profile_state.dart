import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_profile_state.freezed.dart';

@freezed
class AdminProfileState with _$AdminProfileState {
  const factory AdminProfileState.initial() = _InitialState;

  const factory AdminProfileState.loading() = _LoadingState;

  const factory AdminProfileState.loaded({
    required Profile profile,
  }) = _LoadedState;

  const factory AdminProfileState.saving({
    required Profile profile,
  }) = _SavingState;

  const factory AdminProfileState.saved({
    required Profile profile,
  }) = _SavedState;

  const factory AdminProfileState.error({
    required String message,
  }) = _ErrorState;
}
