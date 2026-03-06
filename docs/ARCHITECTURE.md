# Clean Architecture + Bloc/Cubit

Struktur mengikuti Clean Architecture dengan state management Bloc/Cubit, API (Dio), Freezed, l10n, dan tema light/dark.

## FVM (Flutter 3.35.7)

Agar tidak konflik saat `flutter pub get`, gunakan FVM:

```bash
fvm use 3.35.7
fvm flutter pub get
fvm flutter run
```

Atau jalankan script: `./scripts/setup.sh` (dari root project).

## Code generation

```bash
fvm dart run build_runner build --delete-conflicting-outputs   # Freezed/JSON
fvm flutter gen-l10n   # Lokalisasi (jika mengubah file .arb)
```

## Struktur folder

```
lib/
├── core/
│   ├── constants/       # Env, base URL
│   ├── error/
│   ├── network/         # ApiClient (Dio), interceptors
│   ├── theme/            # AppTheme (light/dark), ThemeCubit, ThemeStorage
│   ├── usecases/
│   └── injection/       # GetIt setup
├── l10n/                # ARB + generated (AppLocalizations)
├── features/
│   └── <feature_name>/
│       ├── data/
│       ├── domain/
│       └── presentation/   # cubit + freezed state
└── main.dart
```

## API & Dependency injection

- **ApiClient**: Dio dengan base URL dari `Env.baseUrl`, header, timeout. Di-inject sebagai singleton.
- **GetIt**: `init()` dipanggil di `main()` sebelum `runApp`. Data source → Repository → UseCase → Cubit.

## Freezed

- State (mis. `ThemeState`) memakai `@freezed` untuk union/types dan immutability.
- Generate: `dart run build_runner build --delete-conflicting-outputs`.

## Translation (l10n)

- File ARB: `lib/l10n/app_en.arb`, `lib/l10n/app_id.arb`.
- Generated: `lib/l10n/generated/app_localizations.dart`.
- Pakai: `AppLocalizations.of(context).appTitle`, dll.
- Regenerate: `flutter gen-l10n`.

## Tema (dark / light)

- **AppTheme**: `AppTheme.light`, `AppTheme.dark`.
- **ThemeCubit**: simpan pilihan (light/dark/system) lewat `ThemeStorage` (SharedPreferences).
- **MaterialApp**: `theme`, `darkTheme`, `themeMode: themeState.mode`.

## Fitur

- **Home**: `HomePage` (beranda setelah login; logo, tema, logout).
- **Auth**: Login, Register, Forgot Password (domain/data/presentation + Cubit).
- **Splash / Introduction**: alur pertama kali dan cek token.
