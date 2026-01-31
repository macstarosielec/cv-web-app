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
  FirebaseOptions getFirebaseOptions() =>
      DefaultFirebaseOptions.currentPlatform;
}
