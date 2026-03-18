import 'package:admin_app/di/injection.config.dart';
import 'package:admin_content/di/injection.dart' as admin_content;
import 'package:auth/di/injection.dart' as auth;
import 'package:data/di/injection.dart' as data;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/config/app_config.dart';
import 'package:shared/config/firebase_config.dart';
import 'package:shared/di/injection.dart' as shared;

final GetIt getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
)
Future<void> configureDependencies({required String environment}) async {
  await shared.configureSharedDependencies(getIt, environment: environment);
  await data.configureDataDependencies(getIt, environment: environment);
  await auth.configureAuthDependencies(getIt, environment: environment);
  await admin_content.configureAdminContentDependencies(
    getIt,
    environment: environment,
  );

  getIt
    ..init(environment: environment)
    ..registerSingleton<IFirebaseConfig>(
      getIt<IAppConfig>() as IFirebaseConfig,
    );
}
