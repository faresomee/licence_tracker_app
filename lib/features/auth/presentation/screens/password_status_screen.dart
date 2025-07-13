// features/auth/presentation/screens/password_status_screen.dart
import 'package:flutter/material.dart';
import 'package:licence_tracker_app/features/auth/presentation/screens/request_otp_screen.dart';

class PasswordStatusScreen extends StatelessWidget {
  final bool isSuccess;
  final String? message;

  const PasswordStatusScreen({
    super.key,
    required this.isSuccess,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/logo.png', height: 100),
            const Spacer(),
            Text(
              isSuccess ? "تم تغيير كلمة المرور بنجاح" : "فشل تغيير كلمة المرور",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (message != null && !isSuccess)
              Text(
                message!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            const SizedBox(height: 32),
            Image.asset(
              isSuccess
                  ? 'assets/images/success_icon.png'
                  : 'assets/images/failed_icon.png',
              height: 150,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // في كلتا الحالتين، نعود إلى بداية عملية تسجيل الدخول
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const RequestOtpScreen()),
                  (route) => false,
                );
              },
              child: Text(isSuccess ? "متابعة لتسجيل الدخول" : "العودة"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}