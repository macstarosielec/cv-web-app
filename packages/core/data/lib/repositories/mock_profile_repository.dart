import 'package:data/datasources/mock_profile_datasource.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@dev
@LazySingleton(as: ProfileRepository)
class MockProfileRepository implements ProfileRepository {
  MockProfileRepository(this._datasource);

  final MockProfileDatasource _datasource;

  @override
  Future<Profile> getProfile() async => _datasource.getProfile();
}
