// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/domain.dart' as _i494;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../datasources/mock_profile_datasource.dart' as _i962;
import '../datasources/mock_project_datasource.dart' as _i979;
import '../datasources/mock_work_experience_datasource.dart' as _i34;
import '../repositories/mock_auth_repository.dart' as _i690;
import '../repositories/mock_profile_repository.dart' as _i37;
import '../repositories/mock_project_repository.dart' as _i881;
import '../repositories/mock_work_experience_repository.dart' as _i355;

const String _dev = 'dev';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i962.MockProfileDatasource>(
      () => _i962.MockProfileDatasource(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i979.MockProjectDatasource>(
      () => _i979.MockProjectDatasource(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i34.MockWorkExperienceDatasource>(
      () => _i34.MockWorkExperienceDatasource(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i494.AuthRepository>(
      () => _i690.MockAuthRepository(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i494.AdminProjectRepository>(
      () => _i881.MockProjectRepository(gh<_i979.MockProjectDatasource>()),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i494.AdminWorkExperienceRepository>(
      () => _i355.MockWorkExperienceRepository(
        gh<_i34.MockWorkExperienceDatasource>(),
      ),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i494.AdminProfileRepository>(
      () => _i37.MockProfileRepository(gh<_i962.MockProfileDatasource>()),
      registerFor: {_dev},
    );
    return this;
  }
}
