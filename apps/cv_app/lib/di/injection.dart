import 'package:cv_app/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
)
Future<void> configureDependencies({required String environment}) async {
  // Initialize data layer (repositories, datasources)
  // await configureDataDependencies(getIt, environment: environment);
  
  // Initialize cv_content feature (cubits, etc.)
  // await configureCvContentDependencies(getIt);
  
  // Initialize app-specific dependencies
  getIt.init(environment: environment);
}
