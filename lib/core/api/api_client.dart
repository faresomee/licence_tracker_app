// core/api/api_client.dart
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:licence_tracker_app/core/api/auth_interceptor.dart'; // أضف هذا

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio() {
    _dio.options.baseUrl = dotenv.env['BASE_URL']!;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    _dio.interceptors.add(AuthInterceptor()); // <-- أضف هذه السطر
  }

  Dio get dio => _dio;
}
