import 'package:data/datasources/firestore_work_experience_datasource.dart';
import 'package:data/utils/exception_mapper.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AdminWorkExperienceRepository)
class FirestoreWorkExperienceRepository
    implements AdminWorkExperienceRepository {
  FirestoreWorkExperienceRepository(this._datasource);

  final FirestoreWorkExperienceDatasource _datasource;

  @override
  Future<List<WorkExperience>> getWorkExperiences() async {
    try {
      return await _datasource.getWorkExperiences();
    } catch (e, st) {
      throw mapException(e, st);
    }
  }

  @override
  Future<void> addWorkExperience(WorkExperience workExperience) async {
    try {
      await _datasource.addWorkExperience(workExperience);
    } catch (e, st) {
      throw mapException(e, st);
    }
  }

  @override
  Future<void> updateWorkExperience(WorkExperience workExperience) async {
    try {
      await _datasource.updateWorkExperience(workExperience);
    } catch (e, st) {
      throw mapException(e, st);
    }
  }

  @override
  Future<void> deleteWorkExperience(String id) async {
    try {
      await _datasource.deleteWorkExperience(id);
    } catch (e, st) {
      throw mapException(e, st);
    }
  }

  @override
  Future<void> reorderWorkExperiences(
    List<WorkExperience> workExperiences,
  ) async {
    try {
      await _datasource.reorderWorkExperiences(workExperiences);
    } catch (e, st) {
      throw mapException(e, st);
    }
  }
}
