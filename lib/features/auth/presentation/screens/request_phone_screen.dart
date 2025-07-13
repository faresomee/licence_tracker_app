// features/auth/presentation/screens/request_phone_screen.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:licence_tracker_app/core/api/api_client.dart';
import 'package:licence_tracker_app/features/auth/presentation/screens/verify_otp_screen.dart';

class RequestPhoneScreen extends StatefulWidget {
  final String username;
  final String password;

  const RequestPhoneScreen({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  State<RequestPhoneScreen> createState() => _RequestPhoneScreenState();
}

class _RequestPhoneScreenState extends State<RequestPhoneScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _requestOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final apiClient = ApiClient();

    try {
      //  API: /police/generate-otp
      final response = await apiClient.dio.post(
        '/police/generate-otp',
        data: {'phone_number': _phoneController.text},
      );
      
      // في التطبيق الحقيقي، الـ OTP سيُرسل عبر SMS
      // لأغراض الاختبار، سنقرأه من الـ Response
      final otp = response.data['sms_otp']?.toString();
      debugPrint('OTP from server (for testing): $otp');
      
      if (mounted) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VerifyOtpScreen(
            username: widget.username,
            password: widget.password,
            phoneNumber: _phoneController.text,
          ),
        ));
      }

    } on DioException catch (e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.response?.data['message'] ?? 'حدث خطأ ما')),
        );
      }
    } finally {
      if(mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
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
                "رمز التأكيد لحسابك",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                "يرجى إدخال رقم الهاتف لنرسل لك رمز الدخول",
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
                  hintText: "+12345678910",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "الرجاء إدخال رقم الهاتف" : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _requestOtp,
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