import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:fansedu_flutter_mobile/core/error/failures.dart';
import 'package:fansedu_flutter_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:fansedu_flutter_mobile/features/auth/data/datasources/auth_storage.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/entities/auth_result_entity.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthStorage storage,
  })  : _remote = remote,
        _storage = storage;

  final AuthRemoteDataSource _remote;
  final AuthStorage _storage;

  @override
  Future<Either<Failure, AuthResultEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _remote.login(email: email, password: password);
      await _storage.saveToken(res.token);
      return Right(
        AuthResultEntity(token: res.token, user: res.user.toEntity()),
      );
    } on DioException catch (e) {
      final msg = _dioErrorMessage(e);
      return Left(ServerFailure(message: msg));
    } catch (_) {
      return const Left(UnknownFailure(message: 'Login failed'));
    }
  }

  @override
  Future<Either<Failure, AuthResultEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await _remote.register(
        name: name,
        email: email,
        password: password,
      );
      await _storage.saveToken(res.token);
      return Right(
        AuthResultEntity(token: res.token, user: res.user.toEntity()),
      );
    } on DioException catch (e) {
      final msg = _dioErrorMessage(e);
      return Left(ServerFailure(message: msg));
    } catch (_) {
      return const Left(UnknownFailure(message: 'Registration failed'));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    try {
      await _remote.forgotPassword(email: email);
      return const Right(null);
    } on DioException catch (e) {
      final msg = _dioErrorMessage(e);
      return Left(ServerFailure(message: msg));
    } catch (_) {
      return const Left(UnknownFailure(message: 'Request failed'));
    }
  }

  @override
  Future<String?> getToken() => _storage.getToken();

  @override
  Future<void> saveToken(String token) => _storage.saveToken(token);

  @override
  Future<void> clearToken() => _storage.clearToken();

  String _dioErrorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final msg = data['message'] ?? data['error'] ?? data['msg'];
      if (msg != null) return msg.toString();
    }
    return e.message ?? 'Network error';
  }
}
