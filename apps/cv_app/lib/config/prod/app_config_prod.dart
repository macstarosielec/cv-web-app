import 'package:cv_app/config/prod/firebase_options_prod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/config/app_config.dart';
import 'package:shared/config/firebase_config.dart';
import 'package:shared/constants/app_constants.dart';

@prod
@Injectable(as: IAppConfig)
class AppConfigProd implements IAppConfig, IFirebaseConfig {
  @override
  String get appName => AppConstants.cvAppNameProd;

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
      'https://8c4085be0f23671b29b9d329c9335b1e@o4511066998112256.ingest.de.sentry.io/4511067043856464';

  @override
  FirebaseOptions getFirebaseOptions() =>
      DefaultFirebaseOptions.currentPlatform;
}
