import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/di/injection.config.dart';

@InjectableInit(
  preferRelativeImports: true,
)
Future<void> configureSharedDependencies(
  GetIt getIt, {
  required String environment,
}) async {
  getIt.init(environment: environment);
}
