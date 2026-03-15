// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  fullName: json['fullName'] as String,
  title: json['title'] as String,
  about: json['about'] as String,
  email: json['email'] as String,
  phoneNumber: json['phoneNumber'] as String?,
  linkedInUrl: json['linkedInUrl'] as String?,
  githubUrl: json['githubUrl'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  location: json['location'] as String?,
  timezone: json['timezone'] as String?,
  cvUrl: json['cvUrl'] as String?,
  skills:
      (json['skills'] as List<dynamic>?)
          ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  languages:
      (json['languages'] as List<dynamic>?)
          ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  interests:
      (json['interests'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'fullName': instance.fullName,
  'title': instance.title,
  'about': instance.about,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'linkedInUrl': instance.linkedInUrl,
  'githubUrl': instance.githubUrl,
  'avatarUrl': instance.avatarUrl,
  'location': instance.location,
  'timezone': instance.timezone,
  'cvUrl': instance.cvUrl,
  'skills': instance.skills,
  'languages': instance.languages,
  'interests': instance.interests,
};
