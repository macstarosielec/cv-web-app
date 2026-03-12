import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_experience.freezed.dart';
part 'work_experience.g.dart';

@freezed
abstract class WorkExperience with _$WorkExperience {
  const factory WorkExperience({
    required String id,
    required String title,
    required String company,
    required DateTime startDate,
    DateTime? endDate,
    @Default([]) List<String> responsibilities,
    @Default(0) int sortOrder,
  }) = _WorkExperience;

  factory WorkExperience.fromJson(Map<String, dynamic> json) =>
      _$WorkExperienceFromJson(json);

  const WorkExperience._();

  bool get isCurrent => endDate == null;
}
