import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fansedu_flutter_mobile/features/auth/domain/entities/auth_result_entity.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/usecases/register_usecase.dart';
import 'package:fansedu_flutter_mobile/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        super(const AuthState());

  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    final result = await _loginUseCase(LoginParams(email: email, password: password));
    result.fold(
      (f) => emit(state.copyWith(status: AuthStatus.failure, errorMessage: f.message)),
      (AuthResultEntity r) => emit(state.copyWith(status: AuthStatus.success, result: r)),
    );
  }

  Future<void> register(String name, String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    final result = await _registerUseCase(
      RegisterParams(name: name, email: email, password: password),
    );
    result.fold(
      (f) => emit(state.copyWith(status: AuthStatus.failure, errorMessage: f.message)),
      (AuthResultEntity r) => emit(state.copyWith(status: AuthStatus.success, result: r)),
    );
  }

  Future<bool> forgotPassword(String email) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    final result = await _forgotPasswordUseCase(email);
    return result.fold(
      (f) {
        emit(state.copyWith(status: AuthStatus.failure, errorMessage: f.message));
        return false;
      },
      (_) {
        emit(state.copyWith(status: AuthStatus.initial));
        return true;
      },
    );
  }

  void clearError() {
    emit(state.copyWith(status: AuthStatus.initial, errorMessage: null));
  }
}
