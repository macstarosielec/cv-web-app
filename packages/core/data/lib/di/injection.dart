import 'package:data/di/injection.config.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  preferRelativeImports: true,
)
Future<void> configureDataDependencies(
  GetIt getIt, {
  required String environment,
}) async {
  getIt.init(environment: environment);

  // Register parent interfaces so cv_app cubits can resolve read-only repos
  if (getIt.isRegistered<AdminProfileRepository>()) {
    getIt.registerLazySingleton<ProfileRepository>(
      () => getIt<AdminProfileRepository>(),
    );
  }
  if (getIt.isRegistered<AdminProjectRepository>()) {
    getIt.registerLazySingleton<ProjectRepository>(
      () => getIt<AdminProjectRepository>(),
    );
  }
  if (getIt.isRegistered<AdminWorkExperienceRepository>()) {
    getIt.registerLazySingleton<WorkExperienceRepository>(
      () => getIt<AdminWorkExperienceRepository>(),
    );
  }
}
