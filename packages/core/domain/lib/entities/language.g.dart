// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Language _$LanguageFromJson(Map<String, dynamic> json) => _Language(
  name: json['name'] as String,
  proficiency: $enumDecode(_$LanguageProficiencyEnumMap, json['proficiency']),
);

Map<String, dynamic> _$LanguageToJson(_Language instance) => <String, dynamic>{
  'name': instance.name,
  'proficiency': _$LanguageProficiencyEnumMap[instance.proficiency]!,
};

const _$LanguageProficiencyEnumMap = {
  LanguageProficiency.a1: 'A1',
  LanguageProficiency.a2: 'A2',
  LanguageProficiency.b1: 'B1',
  LanguageProficiency.b2: 'B2',
  LanguageProficiency.c1: 'C1',
  LanguageProficiency.c2: 'C2',
  LanguageProficiency.native: 'NATIVE',
};
