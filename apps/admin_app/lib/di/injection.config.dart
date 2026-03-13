// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/config/app_config.dart' as _i739;

import '../config/dev/app_config_dev.dart' as _i122;
import '../config/prod/app_config_prod.dart' as _i497;

const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i739.IAppConfig>(
      () => _i122.AppConfigDev(),
      registerFor: {_dev},
    );
    gh.factory<_i739.IAppConfig>(
      () => _i497.AppConfigProd(),
      registerFor: {_prod},
    );
    return this;
  }
}
