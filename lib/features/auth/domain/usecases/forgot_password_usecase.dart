import 'package:dartz/dartz.dart';
import 'package:fansedu_flutter_mobile/core/error/failures.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  ForgotPasswordUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, void>> call(String email) {
    return _repository.forgotPassword(email: email);
  }
}
