import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_experience_state.freezed.dart';

@freezed
class WorkExperienceState with _$WorkExperienceState {
  const factory WorkExperienceState.initial() = _InitialState;

  const factory WorkExperienceState.loading() = _LoadingState;

  const factory WorkExperienceState.loaded({
    required List<WorkExperience> experiences,
  }) = _LoadedState;

  const factory WorkExperienceState.error({
    required String message,
  }) = _ErrorState;
}
