import 'package:dio/dio.dart';
import 'package:fansedu_flutter_mobile/core/constants/env.dart';

/// Dio-based API client. Registered in DI.
class ApiClient {
  ApiClient({BaseOptions? baseOptions}) : _dio = Dio(baseOptions ?? _defaultOptions);

  final Dio _dio;

  static BaseOptions get _defaultOptions => BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: <String, dynamic>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          if (Env.apiKey.isNotEmpty) 'Authorization': 'Bearer ${Env.apiKey}',
        },
      );

  Dio get dio => _dio;

  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }
}
