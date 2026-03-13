import 'package:data/datasources/mock_project_datasource.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@dev
@LazySingleton(as: AdminProjectRepository)
class MockProjectRepository implements AdminProjectRepository {
  MockProjectRepository(this._datasource);

  final MockProjectDatasource _datasource;

  @override
  Future<List<Project>> getProjects() async => _datasource.getProjects();

  @override
  Future<void> addProject(Project project) async {}

  @override
  Future<void> updateProject(Project project) async {}

  @override
  Future<void> deleteProject(String id) async {}

  @override
  Future<void> reorderProjects(List<Project> projects) async {}
}
