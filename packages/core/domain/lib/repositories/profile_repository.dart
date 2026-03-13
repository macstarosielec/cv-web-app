import 'package:domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
}

abstract class AdminProfileRepository extends ProfileRepository {
  Future<void> saveProfile(Profile profile);
}
