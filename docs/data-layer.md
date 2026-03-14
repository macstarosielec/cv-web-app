# Data Layer

`packages/core/data/` provides repository implementations with environment-based datasource swapping.

## Firestore Datasources (@prod)

Production datasources read from and write to Cloud Firestore:

- `FirestoreProfileDatasource` — reads/writes profile document; manually serializes nested `Skill` and `Language` objects via `.toJson()` (Freezed's generated `toJson()` doesn't deeply serialize nested Freezed objects)
- `FirestoreProjectDatasource` — reads/writes project documents; strips `id` from stored data (uses document ID)
- `FirestoreWorkExperienceDatasource` — reads/writes work experience documents

Repositories: `FirestoreProfileRepository`, `FirestoreProjectRepository`, `FirestoreWorkExperienceRepository` — all annotated `@prod @LazySingleton`.

## Mock Datasources (@dev)

Development datasources return hardcoded sample data:

- `MockProfileDatasource` — sample profile
- `MockProjectDatasource` — 8 commercial + 3 personal sample projects
- `MockWorkExperienceDatasource` — 3 work experience entries

Repositories: `MockProfileRepository`, `MockProjectRepository`, `MockWorkExperienceRepository` — all annotated `@dev @LazySingleton`.

Injectable swaps datasources automatically based on the environment string passed during bootstrap.

## Nested Freezed Serialization

Freezed's generated `toJson()` doesn't call `.toJson()` on nested Freezed objects in lists. The Firestore datasources work around this by manually mapping:

```dart
Future<void> saveProfile(Profile profile) {
  final json = profile.toJson();
  json['skills'] = profile.skills.map((s) => s.toJson()).toList();
  json['languages'] = profile.languages.map((l) => l.toJson()).toList();
  return _doc.set(json);
}
```
