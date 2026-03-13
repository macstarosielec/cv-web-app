import 'package:domain/entities/work_experience.dart';

abstract class WorkExperienceRepository {
  Future<List<WorkExperience>> getWorkExperiences();
}

abstract class AdminWorkExperienceRepository extends WorkExperienceRepository {
  Future<void> addWorkExperience(WorkExperience workExperience);
  Future<void> updateWorkExperience(WorkExperience workExperience);
  Future<void> deleteWorkExperience(String id);
  Future<void> reorderWorkExperiences(List<WorkExperience> workExperiences);
}
