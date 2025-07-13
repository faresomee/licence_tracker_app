// features/auth/presentation/screens/forget_password_screen.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:licence_tracker_app/core/api/api_client.dart';
import 'package:licence_tracker_app/features/auth/presentation/screens/change_password_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _requestPasswordResetOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final apiClient = ApiClient();

    try {
      // API: /police/generate-otp/password
      await apiClient.dio.post('/police/generate-otp/password', data: {
        'phone_number': _phoneController.text,
      });

      if (mounted) {
        // ننتقل إلى شاشة تغيير كلمة المرور ونمرر رقم الهاتف
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(
            phoneNumber: _phoneController.text,
          ),
        ));
      }
    } on DioException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  e.response?.data['message'] ?? 'فشل إرسال الرمز، تأكد من الرقم')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
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
              Image.asset('assets/images/logo.png', height: 100),
              const SizedBox(height: 40),
              const Text(
                "نسيان كلمة المرور",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF003C71)),
              ),
              const SizedBox(height: 16),
              const Text(
                "يرجى إدخال رقم الهاتف لنرسل لك رمز التحقق لتغيير كلمة المرور",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: "رقم الهاتف",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "الرجاء إدخال رقم الهاتف" : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _requestPasswordResetOtp,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("تحقق"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}