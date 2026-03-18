// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:domain/domain.dart' as _i494;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../datasources/firebase_auth_datasource.dart' as _i164;
import '../datasources/firestore_profile_datasource.dart' as _i792;
import '../datasources/firestore_project_datasource.dart' as _i315;
import '../datasources/firestore_work_experience_datasource.dart' as _i594;
import '../repositories/firebase_auth_repository.dart' as _i207;
import '../repositories/firestore_profile_repository.dart' as _i371;
import '../repositories/firestore_project_repository.dart' as _i182;
import '../repositories/firestore_work_experience_repository.dart' as _i711;
import 'firebase_module.dart' as _i616;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.auth);
    gh.lazySingleton<_i792.FirestoreProfileDatasource>(
      () => _i792.FirestoreProfileDatasource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i315.FirestoreProjectDatasource>(
      () => _i315.FirestoreProjectDatasource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i594.FirestoreWorkExperienceDatasource>(
      () => _i594.FirestoreWorkExperienceDatasource(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i164.FirebaseAuthDatasource>(
      () => _i164.FirebaseAuthDatasource(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i494.AdminProjectRepository>(
      () => _i182.FirestoreProjectRepository(
        gh<_i315.FirestoreProjectDatasource>(),
      ),
    );
    gh.lazySingleton<_i494.AdminWorkExperienceRepository>(
      () => _i711.FirestoreWorkExperienceRepository(
        gh<_i594.FirestoreWorkExperienceDatasource>(),
      ),
    );
    gh.lazySingleton<_i494.AuthRepository>(
      () => _i207.FirebaseAuthRepository(gh<_i164.FirebaseAuthDatasource>()),
    );
    gh.lazySingleton<_i494.AdminProfileRepository>(
      () => _i371.FirestoreProfileRepository(
        gh<_i792.FirestoreProfileDatasource>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i616.FirebaseModule {}
