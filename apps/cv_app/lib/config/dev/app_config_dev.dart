import 'package:cv_app/config/dev/firebase_options_dev.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/config/app_config.dart';
import 'package:shared/config/firebase_config.dart';
import 'package:shared/constants/app_constants.dart';

@dev
@Injectable(as: IAppConfig)
class AppConfigDev implements IAppConfig, IFirebaseConfig {
  @override
  String get appName => AppConstants.cvAppNameDev;

  @override
  String get environment => Environment.dev;

  @override
  bool get isLogBlocChanges => false;

  @override
  bool get isLogBlocErrors => true;

  @override
  bool get alwaysAnimateEntrance => true;

  @override
  String get sentryDsn =>
      'https://37f6c2b660050d2e133ae8882b8c1f71@o4511066998112256.ingest.de.sentry.io/4511067007615056';

  @override
  FirebaseOptions getFirebaseOptions() =>
      DefaultFirebaseOptions.currentPlatform;
}
