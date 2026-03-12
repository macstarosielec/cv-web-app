import 'package:data/datasources/mock_project_datasource.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@dev
@LazySingleton(as: ProjectRepository)
class MockProjectRepository implements ProjectRepository {
  MockProjectRepository(this._datasource);

  final MockProjectDatasource _datasource;

  @override
  Future<List<Project>> getProjects() async => _datasource.getProjects();
}
