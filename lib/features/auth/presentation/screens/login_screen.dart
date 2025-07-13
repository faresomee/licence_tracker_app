// features/auth/presentation/screens/login_screen.dart
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // استيراد الحزمة
import 'package:licence_tracker_app/core/api/api_client.dart';
import 'package:licence_tracker_app/features/auth/presentation/screens/login_status_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:licence_tracker_app/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:licence_tracker_app/features/police_home/presentation/screens/main_screen.dart'; // استيراد الشاشة الرئيسية

class LoginScreen extends StatefulWidget {
  final String phoneNumber;

  const LoginScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    final apiClient = ApiClient();
    
    try {
      // API: /police/login
      final response = await apiClient.dio.post(
        '/police/login',
        data: {
          'username': _usernameController.text,
          'password': _passwordController.text,
          'phone_number': widget.phoneNumber,
          'sms_otp': _otpController.text,
        },
      );
      
      final token = response.data['token'];
      
      // ================ بداية التعديلات ================
      // حفظ البيانات في Secure Storage
      const storage = FlutterSecureStorage();
      await storage.write(key: 'auth_token', value: token);
      await storage.write(key: 'logout_username', value: _usernameController.text);
      await storage.write(key: 'logout_password', value: _passwordController.text);

      debugPrint('Login successful. Token and user credentials saved.');
      // ================= نهاية التعديلات =================

      if (mounted) {
        // الانتقال إلى الشاشة الرئيسية بدلاً من شاشة الحالة
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (Route<dynamic> route) => false,
        );
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'فشل التحقق من الرمز';
      if (mounted) {
        // عند الفشل، ننتقل إلى شاشة عرض الحالة
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginStatusScreen(isSuccess: false, message: message)),
          (Route<dynamic> route) => false,
        );
      }
    } finally {
       if (mounted) setState(() => _isLoading = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/logo.png', height: 80),
              const SizedBox(height: 40),
              
              // Username
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "اسم المستخدم", border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? "الرجاء إدخال اسم المستخدم" : null,
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: "كلمة المرور",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  ),
                ),
                validator: (value) => value!.isEmpty ? "الرجاء إدخال كلمة المرور" : null,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgetPasswordScreen(),
                    ));
                  },
                  child: const Text("نسيت كلمة المرور؟"),
                ),
              ),

              const SizedBox(height: 16), 

              // OTP
              const Text("رمز التحقق (OTP)", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  controller: _otpController,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  validator: (value) => value!.length < 4 ? "الرجاء إدخال الرمز كاملاً" : null,
                ),
              ),
              const SizedBox(height: 32),
              
              // Login Button
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16))
                ),
                onPressed: _isLoading ? null : _login,
                child: _isLoading 
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3)) 
                    : const Text("تسجيل الدخول", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}