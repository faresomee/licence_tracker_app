// features/auth/presentation/screens/change_password_screen.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:licence_tracker_app/core/api/api_client.dart';
import 'package:licence_tracker_app/features/auth/presentation/screens/password_status_screen.dart'; // سننشئ هذا الملف
import 'package:pinput/pinput.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String phoneNumber;

  const ChangePasswordScreen({super.key, required this.phoneNumber});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isLoading = false;

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('كلمتا المرور غير متطابقتين')),
        );
        return;
    }

    setState(() => _isLoading = true);
    final apiClient = ApiClient();

    try {
      // API: /police/change/password
      await apiClient.dio.post(
        '/police/change/password',
        data: {
          "password": _passwordController.text,
          "re-password": _confirmPasswordController.text,
          "sms_otp": _otpController.text,
        },
      );
      
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const PasswordStatusScreen(isSuccess: true)),
          (route) => false,
        );
      }
    } on DioException catch (e) {
      if(mounted) {
          Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PasswordStatusScreen(isSuccess: false, message: e.response?.data['message'] ?? 'فشل تغيير كلمة المرور')),
          (route) => false,
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/logo.png', height: 80),
              const SizedBox(height: 30),
              const Text("تغيير كلمة المرور", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("يرجى إدخال كلمة المرور الجديدة", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "كلمة المرور الجديدة", border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'لا يمكن ترك الحقل فارغاً' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "تأكيد كلمة المرور الجديدة", border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'لا يمكن ترك الحقل فارغاً' : null,
              ),
              const SizedBox(height: 20),
               const Text("أدخل رمز التحقق (OTP)", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
               const SizedBox(height: 8),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  controller: _otpController,
                  length: 4,
                  validator: (v) => v!.length < 4 ? 'الرمز غير مكتمل' : null,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _changePassword,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("متابعة"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}