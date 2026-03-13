import 'package:data/datasources/firestore_project_datasource.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AdminProjectRepository)
class FirestoreProjectRepository implements AdminProjectRepository {
  FirestoreProjectRepository(this._datasource);

  final FirestoreProjectDatasource _datasource;

  @override
  Future<List<Project>> getProjects() => _datasource.getProjects();

  @override
  Future<void> addProject(Project project) =>
      _datasource.addProject(project);

  @override
  Future<void> updateProject(Project project) =>
      _datasource.updateProject(project);

  @override
  Future<void> deleteProject(String id) => _datasource.deleteProject(id);

  @override
  Future<void> reorderProjects(List<Project> projects) =>
      _datasource.reorderProjects(projects);
}
