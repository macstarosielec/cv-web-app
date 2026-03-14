import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'projects_state.freezed.dart';

@freezed
class ProjectsState with _$ProjectsState {
  const factory ProjectsState.initial() = _InitialState;

  const factory ProjectsState.loading() = _LoadingState;

  const factory ProjectsState.loaded({
    required List<Project> projects,
  }) = _LoadedState;

  const factory ProjectsState.error({
    required AppException exception,
  }) = _ErrorState;
}
