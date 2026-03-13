import 'package:data/datasources/firestore_work_experience_datasource.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AdminWorkExperienceRepository)
class FirestoreWorkExperienceRepository
    implements AdminWorkExperienceRepository {
  FirestoreWorkExperienceRepository(this._datasource);

  final FirestoreWorkExperienceDatasource _datasource;

  @override
  Future<List<WorkExperience>> getWorkExperiences() =>
      _datasource.getWorkExperiences();

  @override
  Future<void> addWorkExperience(WorkExperience workExperience) =>
      _datasource.addWorkExperience(workExperience);

  @override
  Future<void> updateWorkExperience(WorkExperience workExperience) =>
      _datasource.updateWorkExperience(workExperience);

  @override
  Future<void> deleteWorkExperience(String id) =>
      _datasource.deleteWorkExperience(id);

  @override
  Future<void> reorderWorkExperiences(
    List<WorkExperience> workExperiences,
  ) =>
      _datasource.reorderWorkExperiences(workExperiences);
}
