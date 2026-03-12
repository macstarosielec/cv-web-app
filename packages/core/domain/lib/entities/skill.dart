import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

@freezed
abstract class Skill with _$Skill {
  const factory Skill({
    required String name,
    String? category,
    @Default(0) int sortOrder,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
