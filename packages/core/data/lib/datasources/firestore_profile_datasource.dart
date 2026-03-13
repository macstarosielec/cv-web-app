import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreProfileDatasource {
  FirestoreProfileDatasource(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> get _doc =>
      _firestore.collection('profile').doc('main');

  Future<Profile> getProfile() async {
    final snapshot = await _doc.get();
    return Profile.fromJson(snapshot.data()!);
  }

  Future<void> saveProfile(Profile profile) =>
      _doc.set(profile.toJson());
}
