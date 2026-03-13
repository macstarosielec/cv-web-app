import 'package:firebase_core/firebase_core.dart';

abstract class IFirebaseConfig {
  FirebaseOptions getFirebaseOptions();
}
