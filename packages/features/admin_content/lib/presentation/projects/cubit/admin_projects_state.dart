import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_projects_state.freezed.dart';

@freezed
class AdminProjectsState with _$AdminProjectsState {
  const factory AdminProjectsState.initial() = _InitialState;

  const factory AdminProjectsState.loading() = _LoadingState;

  const factory AdminProjectsState.loaded({
    required List<Project> projects,
  }) = _LoadedState;

  const factory AdminProjectsState.saving({
    required List<Project> projects,
  }) = _SavingState;

  const factory AdminProjectsState.error({
    required AppException exception,
  }) = _ErrorState;
}
