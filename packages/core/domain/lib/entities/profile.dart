import 'package:domain/entities/language.dart';
import 'package:domain/entities/skill.dart';
import 'package:domain/entities/social_link.dart';
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
    String? avatarUrl,
    String? location,
    String? timezone,
    String? cvUrl,
    @Default([]) List<Skill> skills,
    @Default([]) List<Language> languages,
    @Default([]) List<String> interests,
    @Default([]) List<SocialLink> socialLinks,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
