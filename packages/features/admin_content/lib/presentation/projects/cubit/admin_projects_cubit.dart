import 'package:admin_content/presentation/projects/cubit/admin_projects_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AdminProjectsCubit extends Cubit<AdminProjectsState> {
  AdminProjectsCubit(this._projectRepository)
      : super(const AdminProjectsState.initial());

  final AdminProjectRepository _projectRepository;

  Future<void> loadProjects() async {
    emit(const AdminProjectsState.loading());
    try {
      final projects = await _projectRepository.getProjects();
      emit(AdminProjectsState.loaded(projects: projects));
    } on Exception catch (e) {
      emit(AdminProjectsState.error(message: e.toString()));
    }
  }

  Future<void> addProject(Project project) async {
    final current = _currentProjects;
    emit(AdminProjectsState.saving(projects: current));
    try {
      await _projectRepository.addProject(project);
      final updated = await _projectRepository.getProjects();
      emit(AdminProjectsState.loaded(projects: updated));
    } on Exception catch (e) {
      emit(AdminProjectsState.error(message: e.toString()));
    }
  }

  Future<void> updateProject(Project project) async {
    final current = _currentProjects;
    emit(AdminProjectsState.saving(projects: current));
    try {
      await _projectRepository.updateProject(project);
      final updated = await _projectRepository.getProjects();
      emit(AdminProjectsState.loaded(projects: updated));
    } on Exception catch (e) {
      emit(AdminProjectsState.error(message: e.toString()));
    }
  }

  Future<void> deleteProject(String id) async {
    final current = _currentProjects;
    emit(AdminProjectsState.saving(projects: current));
    try {
      await _projectRepository.deleteProject(id);
      final updated = await _projectRepository.getProjects();
      emit(AdminProjectsState.loaded(projects: updated));
    } on Exception catch (e) {
      emit(AdminProjectsState.error(message: e.toString()));
    }
  }

  List<Project> get _currentProjects => state.when(
        initial: () => [],
        loading: () => [],
        loaded: (projects) => projects,
        saving: (projects) => projects,
        error: (_) => [],
      );
}
