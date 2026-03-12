import 'package:domain/entities/language_proficiency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'language.freezed.dart';
part 'language.g.dart';

@freezed
abstract class Language with _$Language {
  const factory Language({
    required String name,
    required LanguageProficiency proficiency,
  }) = _Language;

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
}
