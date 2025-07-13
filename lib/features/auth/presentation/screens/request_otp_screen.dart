// features/auth/presentation/screens/request_otp_screen.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:licence_tracker_app/core/api/api_client.dart';
import 'package:licence_tracker_app/features/auth/presentation/screens/login_screen.dart';

class RequestOtpScreen extends StatefulWidget {
  const RequestOtpScreen({super.key});

  @override
  State<RequestOtpScreen> createState() => _RequestOtpScreenState();
}

class _RequestOtpScreenState extends State<RequestOtpScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _requestOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final apiClient = ApiClient();

    try {
      // API: /police/generate-otp
      final response = await apiClient.dio.post(
        '/police/generate-otp',
        data: {'phone_number': _phoneController.text},
      );

      // في التطبيق الحقيقي، الـ OTP سيُرسل عبر SMS
      // لأغراض الاختبار، سنقرأه من الـ Response
      final otp = response.data['sms_otp']?.toString();
      debugPrint('OTP from server (for testing): $otp');
      
      if (mounted) {
        // الانتقال إلى شاشة تسجيل الدخول مع تمرير رقم الهاتف
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginScreen(
            phoneNumber: _phoneController.text,
          ),
        ));
      }

    } on DioException catch (e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.response?.data['message'] ?? 'رقم الهاتف غير صحيح أو غير مسجل')),
        );
      }
    } finally {
      if(mounted) {
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                Image.asset('assets/images/logo.png', height: 100),
                const SizedBox(height: 40),
                const Text(
                  "رمز التأكيد لحسابك",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF003C71)),
                ),
                const SizedBox(height: 16),
                const Text(
                  "يرجى إدخال رقم الهاتف المسجل لنرسل لك رمز الدخول",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    labelText: "رقم الهاتف",
                    hintText: "05xxxxxxxx",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال رقم الهاتف";
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16))
                  ),
                  onPressed: _isLoading ? null : _requestOtp,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text("إرسال الرمز", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}