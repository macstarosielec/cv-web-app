import 'package:domain/entities/language.dart';
import 'package:domain/entities/skill.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required String fullName,
    required String title,
    required String about,
    required String email,
    String? phoneNumber,
    String? linkedInUrl,
    String? githubUrl,
    String? avatarUrl,
    @Default([]) List<Skill> skills,
    @Default([]) List<Language> languages,
    @Default([]) List<String> interests,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
