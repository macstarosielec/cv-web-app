# CV Web App

Flutter web monorepo with two applications: a **public-facing CV/portfolio website** (`cv_app`) and an **admin dashboard** (`admin_app`) for managing content. Firebase backend (Firestore, Auth, Hosting) with separate dev/prod projects. Clean Architecture, Melos workspace management, Dart 3.10+.

---

## Prerequisites

| Tool | Install |
|------|---------|
| **FVM** | [fvm.app](https://fvm.app/) |
| **Firebase CLI** | [firebase.google.com/docs/cli](https://firebase.google.com/docs/cli) |
| **FlutterFire CLI** | `dart pub global activate flutterfire_cli` |

## Getting Started

```bash
git clone https://github.com/macstarosielec/cv-web-app.git
cd cv-web-app
fvm install
fvm flutter pub get
fvm dart run melos build
fvm dart run melos l10n
fvm dart run melos run run:cv:dev
```

## Project Structure

```
cv-web-app/
├── apps/
│   ├── cv_app/              # Public CV/portfolio web app
│   └── admin_app/           # Admin dashboard (desktop-only, auth, animated transitions, CRUD)
├── packages/
│   ├── core/
│   │   ├── domain/          # Entities (Freezed), repository interfaces
│   │   ├── data/            # Repository implementations, Firestore + mock datasources
│   │   └── shared/          # Theme, DI, localization, shared widgets, config interfaces
│   └── features/
│       ├── cv_content/      # CV display: responsive layouts, animations, detail panels
│       ├── admin_content/   # Admin: profile editor, projects + experience two-column CRUD
│       └── auth/            # Authentication: login card, form validation, sanitization
├── .github/workflows/       # CI/CD for both apps (dev, prod, PR previews)
└── docs/                    # Detailed documentation
```

## Melos Commands

| Command | Description |
|---------|-------------|
| `melos run run:cv:dev` | Launch CV app (dev) in Chrome |
| `melos analyze` | Lint all packages |
| `melos test` | Test all packages |
| `melos build` | Code generation (sequential) |
| `melos build:concurrent` | Code generation (parallel) |
| `melos l10n` | Generate localization files |

> Prefix with `fvm dart run` if `melos` isn't aliased.

## Architecture

```
Feature Packages (presentation) --> core/domain <-- core/data
                                        ^
                                        |
                                    core/shared (theme, DI, widgets, config)
```

| Layer | Package | Contains |
|-------|---------|----------|
| **Domain** | `core/domain` | Entities (Freezed), repository interfaces |
| **Data** | `core/data` | Firestore datasources (`@prod`), mock datasources (`@dev`), repositories |
| **Shared** | `core/shared` | `AppTheme`, localization, DI, shared widgets (GradientCard, MatrixRain, NavigationChip, ActionChip) |
| **Features** | `features/*` | Presentation layers with cubits, pages, widgets, micro-routers |
| **Apps** | `apps/*` | Thin shells: DI wiring, Firebase init, theme config, entry points |

## Key Libraries

| Concern | Library |
|---------|---------|
| DI | `get_it` + `injectable` (`@dev`/`@prod` environments) |
| State | `flutter_bloc` (Cubits + Freezed union states) |
| Routing | `auto_route` v11 (micro-router pattern) |
| Models | `freezed` + `json_serializable` |
| UI | `flutter_hooks` (pages), `StatefulWidget` (multi-controller animations) |
| Backend | Firebase (Firestore, Auth, Hosting, Analytics) |
| Linting | `very_good_analysis` |

## CI/CD

Both apps are built and deployed via GitHub Actions:

| Trigger | Flavor | Deploys |
|---------|--------|---------|
| Push to `develop` | Dev | Both apps to dev hosting (live) |
| Push to `main` | Prod | Both apps to prod hosting (live) |
| Pull request | Dev | Both apps to preview channels |

## Theming

`AppTheme.dark()` accepts accent color parameters. Each app passes its own accent:
- **cv_app**: Red accent (`ColorName.accent`)
- **admin_app**: Electric blue (`#2563EB`)

All widgets read colors from `Theme.of(context).colorScheme` — no hardcoded color references.

## Documentation

Detailed docs are in the [`/docs`](docs/) folder:

- [Architecture & DI](docs/architecture.md) — layers, DI flow, bootstrap sequence
- [Domain Model](docs/domain-model.md) — entities, enums, repository interfaces
- [Data Layer](docs/data-layer.md) — Firestore and mock datasources
- [CV Content Feature](docs/cv-content.md) — responsive layouts, animations, cubits
- [Admin App](docs/admin-app.md) — auth flow, animated transitions, dashboard
- [Environment Setup](docs/environments.md) — dev/prod flavors, Firebase projects
- [Code Generation](docs/code-generation.md) — build_runner, generated file patterns
- [Routing](docs/routing.md) — AutoRoute v11 micro-router pattern
- [Adding a Feature](docs/adding-a-feature.md) — step-by-step guide
- [Firebase](docs/firebase.md) — project setup, hosting, services, Firestore rules
- [Localization](docs/localization.md) — ARB files, generation, usage
- [VS Code](docs/vscode.md) — SDK setup, launch configs
