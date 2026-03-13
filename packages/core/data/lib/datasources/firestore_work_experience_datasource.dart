import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
class FirestoreWorkExperienceDatasource {
  FirestoreWorkExperienceDatasource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('work_experiences');

  Future<List<WorkExperience>> getWorkExperiences() async {
    final snapshot = await _collection.orderBy('sortOrder').get();
    return snapshot.docs.map((doc) {
      final data = Map<String, dynamic>.from(doc.data());
      data['id'] = doc.id;
      _convertTimestampsToIso(data);
      return WorkExperience.fromJson(data);
    }).toList();
  }

  Future<void> addWorkExperience(WorkExperience workExperience) =>
      _collection.doc(workExperience.id).set(_toFirestoreData(workExperience));

  Future<void> updateWorkExperience(WorkExperience workExperience) =>
      _collection
          .doc(workExperience.id)
          .update(_toFirestoreData(workExperience));

  Future<void> deleteWorkExperience(String id) => _collection.doc(id).delete();

  Future<void> reorderWorkExperiences(
    List<WorkExperience> workExperiences,
  ) async {
    final batch = _firestore.batch();
    for (final workExperience in workExperiences) {
      batch.update(
        _collection.doc(workExperience.id),
        {'sortOrder': workExperience.sortOrder},
      );
    }
    await batch.commit();
  }

  Map<String, dynamic> _toFirestoreData(WorkExperience workExperience) {
    final data = Map<String, dynamic>.from(workExperience.toJson());
    data['startDate'] = Timestamp.fromDate(workExperience.startDate);
    if (workExperience.endDate != null) {
      data['endDate'] = Timestamp.fromDate(workExperience.endDate!);
    } else {
      data['endDate'] = null;
    }
    return data;
  }

  void _convertTimestampsToIso(Map<String, dynamic> data) {
    final startDate = data['startDate'];
    if (startDate is Timestamp) {
      data['startDate'] = startDate.toDate().toIso8601String();
    }
    final endDate = data['endDate'];
    if (endDate is Timestamp) {
      data['endDate'] = endDate.toDate().toIso8601String();
    }
  }
}
