# Architecture & Dependency Injection

## Clean Architecture Layers

```
Feature Packages (presentation) --> core/domain <-- core/data
                                        ^
                                        |
                                    core/shared (utilities, config, DI)
```

| Layer | Package | Contains |
|-------|---------|----------|
| **Domain** | `packages/core/domain` | Entities (Freezed), repository interfaces. No Flutter/Firebase dependencies. |
| **Data** | `packages/core/data` | Repository implementations, datasources (Firestore for prod, mock for dev). Depends on domain. |
| **Shared** | `packages/core/shared` | Cross-cutting concerns: `IAppConfig` interface, `AppTheme`, localization, `AppBlocObserver`, `AppRouteObserver`, `AnalyticsService`, `ErrorReportingService` (Sentry), `Breakpoints`, DI setup, generated colors, shared widgets (GradientCard, MatrixRain, NavigationChip, ActionChip). |
| **Features** | `packages/features/*` | Self-contained feature modules. Each owns its presentation layer (pages, cubits/blocs, widgets), its own DI module, and its own micro-router. |
| **Apps** | `apps/*` | Thin shell applications. Wire up DI, Firebase, routing, and theme. Contain environment configs and entry points. |

## Key Libraries

| Concern | Library |
|---------|---------|
| **Dependency Injection** | `get_it` + `injectable` (with `@dev`/`@prod` environment annotations) |
| **State Management** | `flutter_bloc` (Cubit pattern with Freezed union states) |
| **Routing** | `auto_route` v11 with generated type-safe routes |
| **Immutable Models** | `freezed` + `freezed_annotation` |
| **JSON Serialization** | `json_annotation` + `json_serializable` (via build_runner) |
| **UI Hooks** | `flutter_hooks` (HookWidget for pages) |
| **Asset Generation** | `flutter_gen` (color constants from XML) |
| **Linting** | `very_good_analysis` |
| **Firebase** | `firebase_core`, `cloud_firestore`, `firebase_auth`, `firebase_analytics` |
| **Error Reporting** | `sentry_flutter` (Sentry) |

## Dependency Injection Flow

Each package that registers dependencies exposes a `configure*Dependencies(GetIt, {environment})` function. The app's DI entry point orchestrates them in order:

```dart
Future<void> configureDependencies({required String environment}) async {
  // 1. Shared dependencies first
  await shared.configureSharedDependencies(getIt, environment: environment);

  // 2. Data layer (repositories, datasources)
  await data.configureDataDependencies(getIt, environment: environment);

  // 3. Feature modules
  await cv_content.configureCvContentDependencies(getIt, environment: environment);

  // 4. App-specific dependencies (IAppConfig registered per environment)
  getIt.init(environment: environment);

  // 5. Register IFirebaseConfig by casting the IAppConfig instance
  getIt.registerSingleton<IFirebaseConfig>(
    getIt<IAppConfig>() as IFirebaseConfig,
  );
}
```

When adding a new package with injectable dependencies, add its `configure*Dependencies` call here.

## Bootstrap Flow

```
main_dev.dart                          main_prod.dart
      |                                      |
      v                                      v
bootstrap(environment: "dev")    bootstrap(environment: "prod")
      |
      ├── WidgetsFlutterBinding.ensureInitialized()
      ├── configureDependencies()      // GetIt setup for all modules
      ├── Firebase.initializeApp()     // Uses IFirebaseConfig.getFirebaseOptions()
      ├── AnalyticsService()             // Registered in GetIt
      ├── Error handlers                  // FlutterError.onError, PlatformDispatcher.onError → ErrorReportingService (Sentry)
      ├── Bloc.observer = AppBlocObserver() // Wired with ErrorReportingService for error capture
      ├── SentryFlutter.init()           // Wraps app if sentryDsn is configured
      └── runApp(App())
```

## Design Choices

### StatefulWidget vs HookWidget for Animations

The project generally uses `HookWidget` with `flutter_hooks` for pages and views. However, some widgets use `StatefulWidget` with `TickerProviderStateMixin` instead.

**Use HookWidget** for pages/views with simple animation needs (single controller).

**Use StatefulWidget** when the widget owns **multiple independent animation controllers** or needs fine-grained lifecycle control (e.g., `didUpdateWidget` for reacting to prop changes). `TickerProviderStateMixin` provides a vsync source that supports multiple simultaneous tickers.
