import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/constants/app_constants.dart';

@lazySingleton
class FirestoreWorkExperienceDatasource {
  FirestoreWorkExperienceDatasource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore
          .collection(AppConstants.firestoreCollectionWorkExperiences);

  Future<List<WorkExperience>> getWorkExperiences() async {
    final snapshot = await _collection.get();
    final experiences = snapshot.docs.map((doc) {
      final data = Map<String, dynamic>.from(doc.data());
      data['id'] = doc.id;
      _convertTimestampsToIso(data);
      return WorkExperience.fromJson(data);
    }).toList()
      ..sort((a, b) {
        if (a.endDate == null && b.endDate != null) return -1;
        if (a.endDate != null && b.endDate == null) return 1;
        if (a.endDate != null && b.endDate != null) {
          final cmp = b.endDate!.compareTo(a.endDate!);
          if (cmp != 0) return cmp;
        }
        return b.startDate.compareTo(a.startDate);
      });
    return experiences;
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
        {AppConstants.fieldSortOrder: workExperience.sortOrder},
      );
    }
    await batch.commit();
  }

  Map<String, dynamic> _toFirestoreData(WorkExperience workExperience) {
    final data = Map<String, dynamic>.from(workExperience.toJson());
    data[AppConstants.fieldStartDate] =
        Timestamp.fromDate(workExperience.startDate);
    if (workExperience.endDate != null) {
      data[AppConstants.fieldEndDate] =
          Timestamp.fromDate(workExperience.endDate!);
    } else {
      data[AppConstants.fieldEndDate] = null;
    }
    return data;
  }

  void _convertTimestampsToIso(Map<String, dynamic> data) {
    final startDate = data[AppConstants.fieldStartDate];
    if (startDate is Timestamp) {
      data[AppConstants.fieldStartDate] =
          startDate.toDate().toIso8601String();
    }
    final endDate = data[AppConstants.fieldEndDate];
    if (endDate is Timestamp) {
      data[AppConstants.fieldEndDate] =
          endDate.toDate().toIso8601String();
    }
  }
}
