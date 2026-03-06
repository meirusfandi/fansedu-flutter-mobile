# Fansedu Mobile

[![Flutter](https://img.shields.io/badge/Flutter-3.35.7-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9+-0175C2?logo=dart)](https://dart.dev)

Aplikasi mobile **Fansedu Olympiad Informatics Academy** — platform pembelajaran dan kompetisi informatika untuk siswa, dibangun dengan Flutter.

---

## Fitur

- **Autentikasi** — Login, registrasi, dan lupa kata sandi terintegrasi API
- **Dashboard siswa** — Beranda dengan ringkasan progres, kursus, dan kontes
- **Notifikasi** — Halaman notifikasi terpusat
- **Profil & pengaturan** — Data user, tema (terang/gelap), dan logout
- **Splash & onboarding** — Splash screen dan introduction untuk pengguna baru
- **Multi-environment** — Build variant dev, staging, dan production
- **Lokalisasi** — Dukungan bahasa Indonesia dan Inggris (l10n)
- **Tema** — Light / dark mode mengikuti brand Fansedu

---

## Tech stack

| Kategori        | Teknologi |
|-----------------|-----------|
| Framework       | Flutter 3.35.7 |
| State management| Bloc / Cubit |
| Arsitektur      | Clean Architecture (data → domain → presentation) |
| Dependency injection | GetIt |
| HTTP client     | Dio |
| Immutability & code gen | Freezed, Equatable |
| Error handling  | Dartz (Either) |
| Lokalisasi      | flutter_localizations + ARB |
| Penyimpanan lokal | SharedPreferences |

---

## Prasyarat

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (disarankan via [FVM](https://fvm.app) versi **3.35.7**)
- [FVM](https://fvm.app) — Flutter Version Management (opsional tapi disarankan untuk konsistensi tim)

---

## Memulai

### 1. Clone & masuk ke project

```bash
git clone <repository-url>
cd fansedu_flutter_mobile
```

### 2. Gunakan Flutter 3.35.7 (FVM)

```bash
fvm use 3.35.7
fvm flutter pub get
```

### 3. Generate kode (Freezed & l10n)

```bash
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter gen-l10n
```

Atau jalankan script setup sekali jalan:

```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

### 4. Jalankan aplikasi

**Development (dev):**

```bash
fvm flutter run -t lib/main_dev.dart --flavor dev \
  --dart-define=FLAVOR=dev \
  --dart-define=API_BASE_URL=https://api-dev.example.com
```

Atau gunakan script:

```bash
./scripts/run_dev.sh
```

**Staging:**

```bash
./scripts/run_stg.sh
```

**Production:**

```bash
./scripts/run_prod.sh
```

Di **VS Code / Cursor**: pilih konfigurasi **Fansedu (dev)**, **Fansedu (staging)**, atau **Fansedu (prod)** di Run and Debug, lalu jalankan.

---

## Build variants

| Entry point       | Environment | Keterangan        |
|-------------------|-------------|-------------------|
| `lib/main_dev.dart`  | Dev         | Development & API dev   |
| `lib/main_stg.dart`  | Staging     | Staging & API staging   |
| `lib/main.dart`      | Production  | Production & API prod    |

Variabel environment (via `--dart-define`):

- `FLAVOR` — `dev` \| `staging` \| `prod`
- `API_BASE_URL` — Base URL backend API
- `API_KEY` — (opsional) API key

Detail konfigurasi Android flavor, build release, dan iOS: lihat [docs/BUILD_VARIANTS.md](docs/BUILD_VARIANTS.md).

---

## Struktur project

```
lib/
├── app.dart                 # Root widget (MaterialApp, theme, l10n)
├── main.dart                # Entry production
├── main_dev.dart             # Entry development
├── main_stg.dart             # Entry staging
├── core/
│   ├── constants/           # Env, AppColors, AppAssets
│   ├── error/                # Failures & Exceptions
│   ├── network/              # ApiClient (Dio), AuthInterceptor, LogInterceptor
│   ├── storage/              # IntroStorage
│   ├── theme/                # AppTheme, ThemeCubit, ThemeStorage
│   ├── usecases/             # Base UseCase
│   └── injection/            # GetIt (DI)
├── l10n/                     # ARB + generated (AppLocalizations)
└── features/
    ├── auth/                 # Login, register, forgot password
    ├── dashboard/            # Dashboard siswa
    ├── home/                 # Shell + bottom nav (Dashboard, Notifikasi, Profil)
    ├── introduction/         # Onboarding
    ├── notification/         # Halaman notifikasi
    ├── profile/              # Profil & pengaturan
    └── splash/               # Splash screen
```

Setiap feature mengikuti lapisan **data** (datasource, model, repository impl), **domain** (entity, repository, use case), dan **presentation** (cubit/bloc, pages, widgets).

---

## Scripts

| Script            | Fungsi |
|-------------------|--------|
| `scripts/setup.sh`   | FVM use, `pub get`, build_runner, gen-l10n |
| `scripts/run_dev.sh` | Jalankan app environment dev |
| `scripts/run_stg.sh` | Jalankan app environment staging |
| `scripts/run_prod.sh`| Jalankan app environment production |

---

## Dokumentasi

- [Arsitektur & pola](docs/ARCHITECTURE.md) — Clean Architecture, Bloc, DI, tema, l10n
- [Build variants](docs/BUILD_VARIANTS.md) — Dev / staging / prod, Android flavors, release build

---

## API backend

Aplikasi memanggil REST API dengan konfigurasi per environment:

- **Auth**: `POST /auth/login`, `POST /auth/register`, `POST /auth/forgot-password`
- Base URL diset lewat `--dart-define=API_BASE_URL=...`
- Token disimpan setelah login dan dikirim di header `Authorization: Bearer <token>`

Sesuaikan endpoint dan format response di layer **data** (mis. `AuthRemoteDataSource`, model) jika backend berbeda.

---

## Lisensi

Proyek ini proprietary — Fansedu Olympiad Informatics Academy.
