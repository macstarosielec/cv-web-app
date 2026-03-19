# Environment & Flavor Setup

The project uses two Firebase projects and two app entry points per app to separate dev and prod environments.

## How It Works

1. **Entry points**: `main_dev.dart` calls `bootstrap(environment: Environment.dev)`, `main_prod.dart` calls `bootstrap(environment: Environment.prod)`. Constants come from the `injectable` package.

2. **IAppConfig interface** (`packages/core/shared/lib/config/app_config.dart`):
   ```dart
   abstract class IAppConfig {
     String get environment;
     String get appName;
     bool get isLogBlocChanges;
     bool get isLogBlocErrors;
     bool get alwaysAnimateEntrance;
     String get sentryDsn;
   }
   ```
   `IFirebaseConfig` is a separate interface for `FirebaseOptions getFirebaseOptions()`. When `sentryDsn` is non-empty, the bootstrap wraps the app with `SentryFlutter.init()` for automatic error reporting.

3. **Environment implementations** (in each app's `lib/config/dev/` and `prod/`):
   - `AppConfigDev` annotated `@dev @Injectable(as: IAppConfig)` — registered only for dev
   - `AppConfigProd` annotated `@prod @Injectable(as: IAppConfig)` — registered only for prod
   - Each implements both `IAppConfig` and `IFirebaseConfig`

4. **Firebase projects**:
   - Dev: `cv-web-app-dev`
   - Prod: `cv-web-app-prod`

## Running a Specific Environment

```bash
# Dev (from project root)
fvm dart run melos run run:cv:dev

# Or directly from an app directory:
flutter run -d chrome -t lib/main_dev.dart

# Prod:
flutter run -d chrome -t lib/main_prod.dart
```
