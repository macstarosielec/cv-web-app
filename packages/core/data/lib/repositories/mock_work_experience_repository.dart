import 'package:data/datasources/mock_work_experience_datasource.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@dev
@LazySingleton(as: AdminWorkExperienceRepository)
class MockWorkExperienceRepository implements AdminWorkExperienceRepository {
  MockWorkExperienceRepository(this._datasource);

  final MockWorkExperienceDatasource _datasource;

  @override
  Future<List<WorkExperience>> getWorkExperiences() async =>
      _datasource.getWorkExperiences();

  @override
  Future<void> addWorkExperience(WorkExperience workExperience) async {}

  @override
  Future<void> updateWorkExperience(WorkExperience workExperience) async {}

  @override
  Future<void> deleteWorkExperience(String id) async {}

  @override
  Future<void> reorderWorkExperiences(
    List<WorkExperience> workExperiences,
  ) async {}
}
