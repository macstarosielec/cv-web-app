import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreProjectDatasource {
  FirestoreProjectDatasource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('projects');

  Future<List<Project>> getProjects() async {
    final snapshot = await _collection.orderBy('sortOrder').get();
    return snapshot.docs.map((doc) {
      final data = {...doc.data(), 'id': doc.id};
      return Project.fromJson(data);
    }).toList();
  }

  Future<void> addProject(Project project) =>
      _collection.doc(project.id).set(project.toJson());

  Future<void> updateProject(Project project) =>
      _collection.doc(project.id).update(project.toJson());

  Future<void> deleteProject(String id) => _collection.doc(id).delete();

  Future<void> reorderProjects(List<Project> projects) async {
    final batch = _firestore.batch();
    for (final project in projects) {
      batch.update(
        _collection.doc(project.id),
        {'sortOrder': project.sortOrder},
      );
    }
    await batch.commit();
  }
}
