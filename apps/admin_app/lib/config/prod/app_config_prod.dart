import 'package:admin_app/config/prod/firebase_options_prod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/config/app_config.dart';
import 'package:shared/config/firebase_config.dart';
import 'package:shared/constants/app_constants.dart';

@prod
@Injectable(as: IAppConfig)
class AppConfigProd implements IAppConfig, IFirebaseConfig {
  @override
  String get appName => AppConstants.adminAppNameProd;

  @override
  String get environment => Environment.prod;

  @override
  bool get isLogBlocChanges => false;

  @override
  bool get isLogBlocErrors => false;

  @override
  bool get alwaysAnimateEntrance => false;

  @override
  String get sentryDsn =>
      'https://e27a0a880e9314a8c37696a14ad1fa6c@o4511066998112256.ingest.de.sentry.io/4511067047329872';

  @override
  String get recaptchaSiteKey => '6LfTR5AsAAAAAE7MkBxxMNMA871LzgX8Sjz7P3Dd';

  @override
  FirebaseOptions getFirebaseOptions() =>
      DefaultFirebaseOptions.currentPlatform;
}
