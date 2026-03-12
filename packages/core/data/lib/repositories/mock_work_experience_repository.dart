import 'package:data/datasources/mock_work_experience_datasource.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@dev
@LazySingleton(as: WorkExperienceRepository)
class MockWorkExperienceRepository implements WorkExperienceRepository {
  MockWorkExperienceRepository(this._datasource);

  final MockWorkExperienceDatasource _datasource;

  @override
  Future<List<WorkExperience>> getWorkExperiences() async =>
      _datasource.getWorkExperiences();
}
