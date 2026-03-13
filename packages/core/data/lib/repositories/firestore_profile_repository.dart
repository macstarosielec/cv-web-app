import 'package:data/datasources/firestore_profile_datasource.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AdminProfileRepository)
class FirestoreProfileRepository implements AdminProfileRepository {
  FirestoreProfileRepository(this._datasource);

  final FirestoreProfileDatasource _datasource;

  @override
  Future<Profile> getProfile() => _datasource.getProfile();

  @override
  Future<void> saveProfile(Profile profile) =>
      _datasource.saveProfile(profile);
}
