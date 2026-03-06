import 'package:dartz/dartz.dart';
import 'package:fansedu_flutter_mobile/core/error/failures.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/entities/auth_result_entity.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/repositories/auth_repository.dart';

class RegisterParams {
  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });
  final String name;
  final String email;
  final String password;
}

class RegisterUseCase {
  RegisterUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, AuthResultEntity>> call(RegisterParams params) {
    return _repository.register(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}
