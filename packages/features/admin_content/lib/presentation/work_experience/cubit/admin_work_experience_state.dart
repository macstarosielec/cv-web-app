import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_work_experience_state.freezed.dart';

@freezed
class AdminWorkExperienceState with _$AdminWorkExperienceState {
  const factory AdminWorkExperienceState.initial() = _InitialState;

  const factory AdminWorkExperienceState.loading() = _LoadingState;

  const factory AdminWorkExperienceState.loaded({
    required List<WorkExperience> workExperiences,
  }) = _LoadedState;

  const factory AdminWorkExperienceState.saving({
    required List<WorkExperience> workExperiences,
  }) = _SavingState;

  const factory AdminWorkExperienceState.error({
    required String message,
  }) = _ErrorState;
}
