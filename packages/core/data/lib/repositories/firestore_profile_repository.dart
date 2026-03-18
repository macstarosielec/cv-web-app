import 'package:data/datasources/firestore_profile_datasource.dart';
import 'package:data/utils/exception_mapper.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AdminProfileRepository)
class FirestoreProfileRepository implements AdminProfileRepository {
  FirestoreProfileRepository(this._datasource);

  final FirestoreProfileDatasource _datasource;

  @override
  Future<Profile> getProfile() async {
    try {
      return await _datasource.getProfile();
    } catch (e, st) {
      throw mapException(e, st);
    }
  }

  @override
  Future<void> saveProfile(Profile profile) async {
    try {
      await _datasource.saveProfile(profile);
    } catch (e, st) {
      throw mapException(e, st);
    }
  }
}
