// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommercialProject _$CommercialProjectFromJson(Map<String, dynamic> json) =>
    CommercialProject(
      id: json['id'] as String,
      name: json['name'] as String,
      company: json['company'] as String,
      role: json['role'] as String,
      description: json['description'] as String?,
      techStack:
          (json['techStack'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      responsibilities:
          (json['responsibilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CommercialProjectToJson(CommercialProject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'company': instance.company,
      'role': instance.role,
      'description': instance.description,
      'techStack': instance.techStack,
      'responsibilities': instance.responsibilities,
      'sortOrder': instance.sortOrder,
      'runtimeType': instance.$type,
    };

PersonalProject _$PersonalProjectFromJson(Map<String, dynamic> json) =>
    PersonalProject(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      techStack:
          (json['techStack'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      githubUrl: json['githubUrl'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PersonalProjectToJson(PersonalProject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'techStack': instance.techStack,
      'githubUrl': instance.githubUrl,
      'sortOrder': instance.sortOrder,
      'runtimeType': instance.$type,
    };
