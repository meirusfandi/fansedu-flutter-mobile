# Core

Layer inti yang dipakai semua fitur.

- **error/** – `Failure` (presentation/domain) dan `Exception` (data)
- **usecases/** – Base `UseCase<Type, Params>` dengan `Either<Failure, Type>` (dartz)
- **injection/** – GetIt setup, panggil `init()` di `main()` sebelum `runApp`

## Menambah fitur baru

1. Registrasikan di `injection.dart`: Cubit/Bloc (factory), UseCase (lazySingleton), Repository (lazySingleton), DataSource (lazySingleton).
2. Urutan registrasi: DataSource → Repository → UseCase → Cubit/Bloc.
