import 'package:admin_app/app/app.dart';
import 'package:admin_app/di/injection.dart';
import 'package:shared/bootstrap/shared_bootstrap.dart';

Future<void> bootstrap({required String environment}) => sharedBootstrap(
      environment: environment,
      configureDependencies: configureDependencies,
      getIt: getIt,
      app: const App(),
    );
