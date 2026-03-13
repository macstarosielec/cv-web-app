import 'package:domain/entities/project.dart';

abstract class ProjectRepository {
  Future<List<Project>> getProjects();
}

abstract class AdminProjectRepository extends ProjectRepository {
  Future<void> addProject(Project project);
  Future<void> updateProject(Project project);
  Future<void> deleteProject(String id);
  Future<void> reorderProjects(List<Project> projects);
}
