import 'package:equatable/equatable.dart';

import 'package:fansedu_flutter_mobile/features/auth/domain/entities/auth_result_entity.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.result,
    this.errorMessage,
  });

  final AuthStatus status;
  final AuthResultEntity? result;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    AuthResultEntity? result,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, result, errorMessage];
}
