# Adding a New Feature

Step-by-step guide to adding a new feature package.

## 1. Create the Package

```bash
cd packages/features
flutter create --template=package my_feature
```

## 2. Register in Workspace

Add to root `pubspec.yaml`:
```yaml
workspace:
  - packages/features/my_feature
```

## 3. Set Up pubspec.yaml

```yaml
name: my_feature
resolution: workspace
environment:
  sdk: ^3.10.7

dependencies:
  auto_route: ^11.1.0
  domain:
    path: ../../core/domain
  flutter:
    sdk: flutter
  flutter_bloc: ^9.1.1
  flutter_hooks: ^0.21.0
  freezed_annotation: ^3.0.0
  get_it: ^9.2.0
  injectable: ^2.7.1+4
  shared: ^0.0.1

dev_dependencies:
  auto_route_generator: ^10.4.0
  build_runner: ^2.10.5
  flutter_test:
    sdk: flutter
  freezed: ^3.0.0
  injectable_generator: ^2.12.0
  very_good_analysis: ^10.0.0
```

## 4. Create the Feature Router

`lib/router/my_feature_router.dart`:
```dart
import 'package:auto_route/auto_route.dart';
import 'package:my_feature/presentation/my_page.dart';

part 'my_feature_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class MyFeatureRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MyRoute.page),
  ];
}
```

## 5. Create a Page

```dart
@RoutePage()
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: Text('My Feature')),
  );
}
```

## 6. Set Up DI

`lib/di/injection.dart`:
```dart
@InjectableInit(preferRelativeImports: true)
Future<void> configureMyFeatureDependencies(
  GetIt getIt, {
  required String environment,
}) async {
  getIt.init(environment: environment);
}
```

## 7. Export Public API

`lib/my_feature.dart`:
```dart
export 'di/injection.dart';
export 'presentation/my_page.dart';
export 'router/my_feature_router.dart';
export 'router/my_feature_router.gr.dart';
```

## 8. Run Code Generation

```bash
cd packages/features/my_feature
flutter pub run build_runner build --delete-conflicting-outputs
```

## 9. Wire into the App

Add dependency in the app's `pubspec.yaml`, register the DI module in `injection.dart`, and add routes in the app router.

## 10. Additions

Follow-up on the TransportRetryInterceptor change (bug 1475538). Apply exactly these four adjustments, nothing else. No refactors of unrelated code.

1. transport_retry_interceptor.dart — guard the backoff lookup:
   add `assert(backoff.length >= maxRetries, 'backoff must provide a delay for every retry attempt')` to the constructor initializer list. Keep `backoff[attemptIndex]` as is.

2. transport_retry_interceptor.dart — make the retry log useful for on-device verification:
   change the debug log to include attempt number, Dio error type and underlying error type, e.g.
   `'Transport retry ${attemptIndex + 1}/$maxRetries for ${options.method} ${options.path}: ${err.type}, ${err.error.runtimeType}'`.
   Keep it at debug level and keep `_logger?.` null-safe.

3. transport_retry_interceptor_test.dart:
   a) In `buildDio()`, pass `backoff: const [Duration.zero, Duration.zero]` to the interceptor so tests do not sleep.
   b) Add one positive test for the non-DNS connectionError path: adapter throws
      `DioException(requestOptions: options, type: DioExceptionType.connectionError, error: const SocketException('Connection refused'))`
      on the first call, returns 200 on the second; assert `calls == 2` and status 200 for `dio.get('/x')`.
   c) Add one positive test for the 'Connection closed before full header was received' HttpException message on a POST `/x/_get` (same shape as the existing connection-abort test).

4. packages/common/data/lib/utils/request_option_extras.dart:
   run `git diff -w` on this file. If the only difference in the existing `incrementRetryCount()` hunk is whitespace that `dart format` (repo config) does NOT produce, revert that hunk so the diff contains only the new `TransportRetryable` extension. If `dart format` produces that layout, leave it and tell me.

Then run `flutter analyze` and the network package tests, and report: the final diff summary per file, test count, and the answer to point 4.
