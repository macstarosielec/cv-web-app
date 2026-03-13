import 'package:domain/entities/work_experience.dart';

abstract class WorkExperienceRepository {
  Future<List<WorkExperience>> getWorkExperiences();
}
