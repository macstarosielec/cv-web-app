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

import '../presentation/cubit/profile/profile_cubit.dart' as _i377;
import '../presentation/cubit/projects/projects_cubit.dart' as _i415;
import '../presentation/cubit/work_experience/work_experience_cubit.dart'
    as _i468;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i377.ProfileCubit>(
      () => _i377.ProfileCubit(gh<_i494.ProfileRepository>()),
    );
    gh.factory<_i468.WorkExperienceCubit>(
      () => _i468.WorkExperienceCubit(gh<_i494.WorkExperienceRepository>()),
    );
    gh.factory<_i415.ProjectsCubit>(
      () => _i415.ProjectsCubit(gh<_i494.ProjectRepository>()),
    );
    return this;
  }
}
