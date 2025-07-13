// core/storage/auth_storage_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorageService {
  final _storage = const FlutterSecureStorage();

  static const _tokenKey = 'auth_token';
  static const _usernameKey = 'auth_username';
  static const _passwordKey = 'auth_password'; // SECURITY WARNING

  // دالة لحفظ التوكن
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // دالة لقراءة التوكن
  Future<String?> readToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // دالة لحذف التوكن عند تسجيل الخروج
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
  
  // ==================== تحذير أمني ====================
  // الدوال التالية موجودة فقط للتعامل مع متطلبات الـ API الحالية لتسجيل الخروج
  // والتي تطلب كلمة المرور بشكل غير آمن.
  // يجب تعديل الـ API ليعتمد على التوكن فقط في تسجيل الخروج،
  // ومن ثم حذف هذه الدوال.
  Future<void> saveCredentials(String username, String password) async {
    await _storage.write(key: _usernameKey, value: username);
    await _storage.write(key: _passwordKey, value: password);
  }

  Future<Map<String, String?>> readCredentials() async {
    final username = await _storage.read(key: _usernameKey);
    final password = await _storage.read(key: _passwordKey);
    return {'username': username, 'password': password};
  }
  
  Future<void> deleteCredentials() async {
     await _storage.delete(key: _usernameKey);
     await _storage.delete(key: _passwordKey);
  }
  // ======================================================
}