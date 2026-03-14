# Localization

Localization is centralized in the `shared` package.

- **Source ARB files**: `packages/core/shared/l10n/app_en.arb`
- **Config**: `packages/core/shared/l10n.yaml`
- **Generated output**: `packages/core/shared/lib/l10n/app_localizations.dart`

## Adding a New String

Edit `app_en.arb` and run:
```bash
melos l10n:shared
```

## Adding a New Locale

Create `app_<locale>.arb` in the same directory and re-run generation.

## Usage

```dart
import 'package:shared/l10n/l10n.dart';

// In a build method:
AppLocalizations.of(context).appTitle
```
