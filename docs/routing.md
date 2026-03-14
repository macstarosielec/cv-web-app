# Routing with AutoRoute

The project uses **AutoRoute v11** with a micro-router pattern where each feature package defines its own router, and the app-level router aggregates them.

## How It Works

1. **Feature micro-router** (e.g., `packages/features/cv_content/lib/router/cv_content_router.dart`):
   ```dart
   @AutoRouterConfig(replaceInRouteName: 'Page,Route')
   class CvContentRouter extends RootStackRouter {
     @override
     List<AutoRoute> get routes => [
       AutoRoute(page: HomeRoute.page),
     ];
   }
   ```
   This generates `cv_content_router.gr.dart` containing `HomeRoute`, etc.

2. **Page annotation**:
   ```dart
   @RoutePage()
   class HomePage extends HookWidget { ... }
   ```

3. **App-level router** (`apps/cv_app/lib/router/router.dart`):
   ```dart
   @AutoRouterConfig(replaceInRouteName: 'Page,Route')
   class AppRouter extends RootStackRouter {
     @override
     List<AutoRoute> get routes => [
       AutoRoute(page: HomeRoute.page, initial: true),
     ];
   }
   ```
   The app router imports generated route classes from feature packages and composes them.

4. **Integration in App widget**:
   ```dart
   MaterialApp.router(
     routerDelegate: _appRouter.delegate(
       navigatorObservers: () => [AppRouteObserver()],
     ),
     routeInformationParser: _appRouter.defaultRouteParser(),
   )
   ```

## Route Observer

`AppRouteObserver` (in `packages/core/shared`) logs all navigation events for debugging.

## Admin App

The admin app uses `MaterialApp` (not `.router`) with `AdminAuthShell` managing navigation between login and dashboard states via animation phases rather than route changes.
