import 'package:cv_app/config/dev/firebase_options_dev.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/config/app_config.dart';
import 'package:shared/constants/app_constants.dart';

@dev
@Injectable(as: IAppConfig)
class AppConfigDev implements IAppConfig {
  @override
  String? appName = AppConstants.cvAppNameDev;

  @override
  String? environment = Environment.dev;

  @override
  bool isLogBlocChanges = false;

  @override
  bool isLogBlocErrors = true;

  @override
  FirebaseOptions? getFirebaseOptions() =>
      DefaultFirebaseOptions.currentPlatform;
}
