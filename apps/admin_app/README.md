# admin_app

Admin dashboard for managing CV content. Desktop-only, dark theme with electric blue accent. Uses Firebase Auth for authentication.

## Running

```bash
# From project root
melos run run:admin:dev

# Or directly
cd apps/admin_app && flutter run -d chrome -t lib/main_dev.dart
```

## Firebase Hosting

Deploys to separate hosting sites per environment using the `admin` deploy target defined in `.firebaserc`:

| Environment | Site |
|-------------|------|
| Dev | `cv-admin-app-dev` |
| Prod | `cv-admin-app-prod` |

See [docs/firebase.md](../../docs/firebase.md) and [docs/admin-app.md](../../docs/admin-app.md) for details.
