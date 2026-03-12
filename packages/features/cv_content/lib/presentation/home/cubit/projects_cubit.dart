import 'package:cv_content/presentation/home/cubit/projects_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit(this._projectRepository)
      : super(const ProjectsState.initial());

  final ProjectRepository _projectRepository;

  Future<void> loadProjects() async {
    emit(const ProjectsState.loading());
    try {
      final projects = await _projectRepository.getProjects();
      emit(ProjectsState.loaded(projects: projects));
    } on Exception catch (e) {
      emit(ProjectsState.error(message: e.toString()));
    }
  }
}
