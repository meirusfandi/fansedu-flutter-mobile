import 'package:dio/dio.dart';

import 'package:fansedu_flutter_mobile/features/auth/data/datasources/auth_storage.dart';

/// Menambahkan Bearer token ke request jika ada.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storage);
  final AuthStorage _storage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
