# Build Variants

Proyek memakai **flavor** untuk environment: `dev`, `staging`, `prod`.

## Dart (Env)

- **FLAVOR**: `dev` | `staging` | `prod` (via `--dart-define=FLAVOR=...`)
- **API_BASE_URL**: base URL API (via `--dart-define=API_BASE_URL=...`)
- **API_KEY**: (opsional) via `--dart-define=API_KEY=...`

Nilai dipakai di `lib/core/constants/env.dart`. `Env.appName` dan `Env.baseUrl` mengikuti flavor.

## Android

Product flavors di `android/app/build.gradle.kts`:

| Flavor   | Application ID                          | App name          |
|----------|------------------------------------------|-------------------|
| dev      | id.web.fansedu.fansedu_flutter_mobile.dev | Fansedu Dev       |
| staging  | id.web.fansedu.fansedu_flutter_mobile.staging | Fansedu Staging |
| prod     | id.web.fansedu.fansedu_flutter_mobile    | Fansedu           |

**Jalankan (harus pilih flavor):**

```bash
# Dev (default FLAVOR=dev di Env kalau tidak di-define)
fvm flutter run --flavor dev --dart-define=FLAVOR=dev

# Staging + API URL
fvm flutter run --flavor staging --dart-define=FLAVOR=staging --dart-define=API_BASE_URL=https://staging-api.example.com

# Prod
fvm flutter run --flavor prod --dart-define=FLAVOR=prod --dart-define=API_BASE_URL=https://api.example.com
```

**Build release:**

```bash
fvm flutter build apk --flavor prod --dart-define=FLAVOR=prod --dart-define=API_BASE_URL=https://api.example.com
fvm flutter build appbundle --flavor prod --dart-define=FLAVOR=prod --dart-define=API_BASE_URL=https://api.example.com
```

## iOS

Untuk iOS, set FLAVOR dan API_BASE_URL lewat **dart-define** saat run/build (sama seperti Android). Buat scheme di Xcode (mis. Dev, Staging, Prod) dan atur **Run → Arguments → Dart Define** jika perlu.

```bash
fvm flutter run --flavor dev --dart-define=FLAVOR=dev
fvm flutter build ios --flavor prod --dart-define=FLAVOR=prod --dart-define=API_BASE_URL=https://api.example.com
```

(Catatan: `--flavor` di iOS memerlukan konfigurasi scheme di Xcode yang memetakan ke bundle ID/name.)
