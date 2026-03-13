import 'package:domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
}
