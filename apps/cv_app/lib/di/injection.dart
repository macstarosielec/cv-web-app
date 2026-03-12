import 'package:cv_app/di/injection.config.dart';
import 'package:cv_content/di/injection.dart' as cv_content;
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
  // Initialize shared dependencies first
  await shared.configureSharedDependencies(getIt, environment: environment);

  // Initialize data layer (repositories, datasources)
  await data.configureDataDependencies(getIt, environment: environment);

  // Initialize cv_content feature (cubits, etc.)
  await cv_content.configureCvContentDependencies(
    getIt,
    environment: environment,
  );

  // Initialize app-specific dependencies
  getIt.init(environment: environment);

  // Register IFirebaseConfig by casting the IAppConfig instance
  getIt.registerSingleton<IFirebaseConfig>(
    getIt<IAppConfig>() as IFirebaseConfig,
  );
}
