import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fansedu_flutter_mobile/core/network/api_client.dart';
import 'package:fansedu_flutter_mobile/core/network/auth_interceptor.dart';
import 'package:fansedu_flutter_mobile/core/network/dio_interceptors.dart';
import 'package:fansedu_flutter_mobile/core/storage/intro_storage.dart';
import 'package:fansedu_flutter_mobile/core/storage/intro_storage_impl.dart';
import 'package:fansedu_flutter_mobile/core/theme/theme_cubit.dart';
import 'package:fansedu_flutter_mobile/core/theme/theme_storage.dart';
import 'package:fansedu_flutter_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:fansedu_flutter_mobile/features/auth/data/datasources/auth_storage.dart';
import 'package:fansedu_flutter_mobile/features/auth/data/datasources/auth_storage_impl.dart';
import 'package:fansedu_flutter_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/usecases/register_usecase.dart';
import 'package:fansedu_flutter_mobile/features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core - Network (API)
  final apiClient = ApiClient();
  assert(() {
    apiClient.addInterceptor(LogInterceptor());
    return true;
  }());
  sl.registerLazySingleton<ApiClient>(() => apiClient);

  // Core - Theme & Intro (depend on SharedPreferences)
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton<ThemeStorage>(
    () => ThemeStorageImpl(sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<IntroStorage>(
    () => IntroStorageImpl(sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(storage: sl<ThemeStorage>()));

  // Auth
  sl.registerLazySingleton<AuthStorage>(
    () => AuthStorageImpl(sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remote: sl<AuthRemoteDataSource>(),
      storage: sl<AuthStorage>(),
    ),
  );
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(sl<AuthRepository>()),
  );
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      forgotPasswordUseCase: sl<ForgotPasswordUseCase>(),
    ),
  );
  sl<ApiClient>().addInterceptor(AuthInterceptor(sl<AuthStorage>()));
}
