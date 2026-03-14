import 'package:admin_content/presentation/work_experience/cubit/admin_work_experience_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AdminWorkExperienceCubit extends Cubit<AdminWorkExperienceState> {
  AdminWorkExperienceCubit(this._workExperienceRepository)
      : super(const AdminWorkExperienceState.initial());

  final AdminWorkExperienceRepository _workExperienceRepository;

  Future<void> loadWorkExperiences() async {
    emit(const AdminWorkExperienceState.loading());
    try {
      final workExperiences =
          await _workExperienceRepository.getWorkExperiences();
      emit(AdminWorkExperienceState.loaded(workExperiences: workExperiences));
    } on AppException catch (e) {
      emit(AdminWorkExperienceState.error(exception: e));
    }
  }

  Future<void> addWorkExperience(WorkExperience workExperience) async {
    final current = _currentWorkExperiences;
    emit(AdminWorkExperienceState.saving(workExperiences: current));
    try {
      await _workExperienceRepository.addWorkExperience(workExperience);
      final updated = await _workExperienceRepository.getWorkExperiences();
      emit(AdminWorkExperienceState.loaded(workExperiences: updated));
    } on AppException catch (e) {
      emit(AdminWorkExperienceState.error(exception: e));
    }
  }

  Future<void> updateWorkExperience(WorkExperience workExperience) async {
    final current = _currentWorkExperiences;
    emit(AdminWorkExperienceState.saving(workExperiences: current));
    try {
      await _workExperienceRepository.updateWorkExperience(workExperience);
      final updated = await _workExperienceRepository.getWorkExperiences();
      emit(AdminWorkExperienceState.loaded(workExperiences: updated));
    } on AppException catch (e) {
      emit(AdminWorkExperienceState.error(exception: e));
    }
  }

  Future<void> deleteWorkExperience(String id) async {
    final current = _currentWorkExperiences;
    emit(AdminWorkExperienceState.saving(workExperiences: current));
    try {
      await _workExperienceRepository.deleteWorkExperience(id);
      final updated = await _workExperienceRepository.getWorkExperiences();
      emit(AdminWorkExperienceState.loaded(workExperiences: updated));
    } on AppException catch (e) {
      emit(AdminWorkExperienceState.error(exception: e));
    }
  }

  List<WorkExperience> get _currentWorkExperiences => state.when(
        initial: () => [],
        loading: () => [],
        loaded: (workExperiences) => workExperiences,
        saving: (workExperiences) => workExperiences,
        error: (_) => [],
      );
}
