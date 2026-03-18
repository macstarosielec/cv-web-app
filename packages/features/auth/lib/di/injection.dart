import 'package:auth/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  preferRelativeImports: true,
)
Future<void> configureAuthDependencies(
  GetIt getIt, {
  required String environment,
}) async {
  getIt.init(environment: environment);
}
