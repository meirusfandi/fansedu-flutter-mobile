import 'package:dartz/dartz.dart';
import 'package:fansedu_flutter_mobile/core/error/failures.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/entities/auth_result_entity.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/repositories/auth_repository.dart';

class LoginParams {
  const LoginParams({required this.email, required this.password});
  final String email;
  final String password;
}

class LoginUseCase {
  LoginUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, AuthResultEntity>> call(LoginParams params) {
    return _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}
