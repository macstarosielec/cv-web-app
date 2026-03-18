import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/constants/app_constants.dart';

@lazySingleton
class FirestoreProfileDatasource {
  FirestoreProfileDatasource(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> get _doc =>
      _firestore
          .collection(AppConstants.firestoreCollectionProfile)
          .doc(AppConstants.firestoreDocProfileMain);

  Future<Profile> getProfile() async {
    final snapshot = await _doc.get();
    if (!snapshot.exists || snapshot.data() == null) {
      return const Profile(
        fullName: '',
        title: '',
        about: '',
        email: '',
      );
    }
    return Profile.fromJson(snapshot.data()!);
  }

  Future<void> saveProfile(Profile profile) {
    final json = profile.toJson();
    json[AppConstants.fieldSkills] =
        profile.skills.map((s) => s.toJson()).toList();
    json[AppConstants.fieldLanguages] =
        profile.languages.map((l) => l.toJson()).toList();
    json[AppConstants.fieldSocialLinks] =
        profile.socialLinks.map((s) => s.toJson()).toList();
    return _doc.set(json);
  }
}
