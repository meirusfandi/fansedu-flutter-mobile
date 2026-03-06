import 'package:dio/dio.dart';

import 'package:fansedu_flutter_mobile/core/network/api_client.dart';
import 'package:fansedu_flutter_mobile/features/auth/data/models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({required String email, required String password});
  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String password,
  });
  Future<void> forgotPassword({required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return AuthResponseModel.fromJson(
      response.data! as Map<String, dynamic>,
    );
  }

  @override
  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.dio.post<Map<String, dynamic>>(
      '/auth/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    return AuthResponseModel.fromJson(
      response.data! as Map<String, dynamic>,
    );
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await _apiClient.dio.post<Map<String, dynamic>>(
      '/auth/forgot-password',
      data: {'email': email},
    );
  }
}
