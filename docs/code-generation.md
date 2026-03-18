# Code Generation

This project uses `build_runner` extensively. Generated files should not be edited by hand.

## Generated File Patterns

| Pattern | Generator | Trigger |
|---------|-----------|---------|
| `*.freezed.dart` | Freezed | `@freezed` annotation |
| `*.g.dart` | json_serializable / injectable_generator | `@JsonSerializable`, `@InjectableInit` |
| `*.gr.dart` | auto_route_generator | `@AutoRouterConfig`, `@RoutePage()` |
| `lib/gen/colors.gen.dart` | flutter_gen | `assets/colors/colors.xml` in shared package |
| `lib/l10n/app_localizations*.dart` | flutter gen-l10n | ARB files in `packages/core/shared/l10n/` |

## Running Code Generation

```bash
# All packages (sequential, recommended for clean builds)
melos build

# All packages (parallel, faster for incremental builds)
melos build:concurrent

# Single package (run from within that package directory)
flutter pub run build_runner build --delete-conflicting-outputs
```

After modifying any annotated class, re-run code generation for the affected package.

**Important**: For auto_route, run `build_runner` in the feature package where `@RoutePage()` lives, not in the app package.
