import 'package:cv_app/config/prod/firebase_options_prod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/config/app_config.dart';
import 'package:shared/constants/app_constants.dart';

@prod
@Injectable(as: IAppConfig)
class AppConfigProd implements IAppConfig {
  @override
  String? appName = AppConstants.cvAppNameProd;

  @override
  String? environment = Environment.prod;

  @override
  bool isLogBlocChanges = false;

  @override
  bool isLogBlocErrors = false;

  @override
  FirebaseOptions? getFirebaseOptions() =>
      DefaultFirebaseOptions.currentPlatform;
}
