import 'package:admin_app/config/dev/firebase_options_dev.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/config/app_config.dart';
import 'package:shared/config/firebase_config.dart';
import 'package:shared/constants/app_constants.dart';

@dev
@Injectable(as: IAppConfig)
class AppConfigDev implements IAppConfig, IFirebaseConfig {
  @override
  String get appName => AppConstants.adminAppNameDev;

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
      'https://285dcd1344b1900f4a05684cd60a3479@o4511066998112256.ingest.de.sentry.io/4511067038810192';

  @override
  String get recaptchaSiteKey => '6Lf8SZAsAAAAACPDEIeZAC8BIHKIG--hQigQwkQZ';

  @override
  FirebaseOptions getFirebaseOptions() =>
      DefaultFirebaseOptions.currentPlatform;
}
