# cv_app

Public-facing CV/portfolio web app. Responsive layout with multi-panel support on ultrawide screens.

## Running

```bash
# From project root
melos run run:cv:dev

# Or directly
cd apps/cv_app && flutter run -d chrome -t lib/main_dev.dart
```

## Firebase Hosting

Deploys to the default hosting site per environment:

| Environment | Site |
|-------------|------|
| Dev | `cv-web-app-dev` |
| Prod | `cv-web-app-prod` |

See [docs/firebase.md](../../docs/firebase.md) and [docs/cv-content.md](../../docs/cv-content.md) for details.
