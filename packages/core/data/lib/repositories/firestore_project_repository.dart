import 'package:data/datasources/firestore_project_datasource.dart';
import 'package:data/utils/exception_mapper.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AdminProjectRepository)
class FirestoreProjectRepository implements AdminProjectRepository {
  FirestoreProjectRepository(this._datasource);

  final FirestoreProjectDatasource _datasource;

  @override
  Future<List<Project>> getProjects() async {
    try {
      return await _datasource.getProjects();
    } catch (e, st) {
      throw mapException(e, st);
    }
  }

  @override
  Future<void> addProject(Project project) async {
    try {
      await _datasource.addProject(project);
    } catch (e, st) {
      throw mapException(e, st);
    }
  }

  @override
  Future<void> updateProject(Project project) async {
    try {
      await _datasource.updateProject(project);
    } catch (e, st) {
      throw mapException(e, st);
    }
  }

  @override
  Future<void> deleteProject(String id) async {
    try {
      await _datasource.deleteProject(id);
    } catch (e, st) {
      throw mapException(e, st);
    }
  }

  @override
  Future<void> reorderProjects(List<Project> projects) async {
    try {
      await _datasource.reorderProjects(projects);
    } catch (e, st) {
      throw mapException(e, st);
    }
  }
}
