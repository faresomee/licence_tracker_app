// features/auth/presentation/screens/verify_otp_screen.dart
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:licence_tracker_app/core/api/api_client.dart';
import 'package:licence_tracker_app/features/auth/presentation/screens/login_status_screen.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String username;
  final String password;
  final String phoneNumber;

  const VerifyOtpScreen({
    super.key,
    required this.username,
    required this.password,
    required this.phoneNumber,
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _otpController = TextEditingController();
  bool _isLoading = false;
  late Timer _timer;
  int _start = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        if(mounted) setState(() => timer.cancel());
      } else {
        if(mounted) setState(() => _start--);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_otpController.text.length < 4) return;
    
    setState(() => _isLoading = true);
    final apiClient = ApiClient();
    
    try {
      // المرحلة الثانية: تسجيل الدخول الكامل
      // API: POST /police/login
      final response = await apiClient.dio.post(
        '/police/login',
        data: {
          'username': widget.username,
          'password': widget.password,
          'phone_number': widget.phoneNumber,
          'sms_otp': _otpController.text,
        },
      );
      
      final token = response.data['token'];
      debugPrint('Login successful. Token: $token');
      // TODO: Save the token using flutter_secure_storage
      
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginStatusScreen(isSuccess: true)),
          (Route<dynamic> route) => false,
        );
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'فشل التحقق من الرمز';
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginStatusScreen(isSuccess: false, message: message)),
          (Route<dynamic> route) => false,
        );
      }
    } finally {
       if (mounted) setState(() => _isLoading = false);
    }
  }
  
  Future<void> _resendOtp() async {
     setState(() {
      _start = 30;
    });
    // إعادة استدعاء API إرسال الرمز
    await ApiClient().dio.post(
        '/police/generate-otp',
        data: {'phone_number': widget.phoneNumber},
      );
    startTimer();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم إرسال رمز جديد")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... الكود الخاص بالواجهة (UI) لهذه الشاشة لم يتغير وهو صحيح
    // يمكنك نسخ الجزء الخاص بالـ UI من ردي السابق لهذه الشاشة
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/logo.png', height: 100),
            const SizedBox(height: 40),
            const Text("تحقق من رقم الهاتف", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
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
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => _login(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("تحقق من الرمز"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _start > 0 ? null : _resendOtp,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  foregroundColor: Colors.black),
              child: Text(_start > 0
                  ? "إعادة إرسال الرمز (0:${_start.toString().padLeft(2, '0')})"
                  : "إعادة إرسال الرمز"),
            )
          ],
        ),
      ),
    );
  }
}