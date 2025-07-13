// core/api/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final _storage = const FlutterSecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // لا تضف التوكن لطلبات تسجيل الدخول أو استعادة كلمة المرور
    if (!options.path.contains('/login') && !options.path.contains('/generate-otp')) {
      final token = await _storage.read(key: 'auth_token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    super.onRequest(options, handler);
  }
}