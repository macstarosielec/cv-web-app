// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Project _$ProjectFromJson(Map<String, dynamic> json) => _Project(
  id: json['id'] as String,
  name: json['name'] as String,
  company: json['company'] as String,
  role: json['role'] as String,
  description: json['description'] as String?,
  techStack:
      (json['techStack'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  responsibilities:
      (json['responsibilities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ProjectToJson(_Project instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'company': instance.company,
  'role': instance.role,
  'description': instance.description,
  'techStack': instance.techStack,
  'responsibilities': instance.responsibilities,
  'sortOrder': instance.sortOrder,
};
