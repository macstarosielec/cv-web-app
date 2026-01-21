import 'package:firebase_core/firebase_core.dart';

abstract class IAppConfig {
  String? environment;
  String? appName;
  late bool isLogBlocChanges;
  late bool isLogBlocErrors;
  FirebaseOptions? getFirebaseOptions();
}
