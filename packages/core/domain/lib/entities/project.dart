import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
abstract class Project with _$Project {
  const factory Project({
    required String id,
    required String name,
    required String company,
    required String role,
    String? description,
    @Default([]) List<String> techStack,
    @Default([]) List<String> responsibilities,
    @Default(0) int sortOrder,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}
