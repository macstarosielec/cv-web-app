import 'package:cv_content/presentation/experience/cubit/work_experience_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class WorkExperienceCubit extends Cubit<WorkExperienceState> {
  WorkExperienceCubit(this._workExperienceRepository)
      : super(const WorkExperienceState.initial());

  final WorkExperienceRepository _workExperienceRepository;

  Future<void> loadWorkExperiences() async {
    emit(const WorkExperienceState.loading());
    try {
      final experiences =
          await _workExperienceRepository.getWorkExperiences();
      emit(WorkExperienceState.loaded(experiences: experiences));
    } on Exception catch (e) {
      emit(WorkExperienceState.error(message: e.toString()));
    }
  }
}
