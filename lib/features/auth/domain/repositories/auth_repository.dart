import 'package:dartz/dartz.dart';
import 'package:fansedu_flutter_mobile/core/error/failures.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/entities/auth_result_entity.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResultEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthResultEntity>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> forgotPassword({required String email});

  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> clearToken();
  Future<UserEntity?> getStoredUser();
  Future<void> saveUser(UserEntity user);
}
