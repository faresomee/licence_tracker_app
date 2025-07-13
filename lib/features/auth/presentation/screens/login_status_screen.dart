// features/auth/presentation/screens/login_status_screen.dart
import 'package:flutter/material.dart';
// import 'package:licence_tracker_app/features/auth/presentation/screens/login_screen.dart'; // لم نعد بحاجة لهذا
import 'package:licence_tracker_app/features/auth/presentation/screens/request_otp_screen.dart'; // <-- استيراد الشاشة الصحيحة
// افترض وجود شاشة رئيسية باسم HomeScreen
// import 'package:licence_tracker_app/features/home/presentation/screens/home_screen.dart'; 

class LoginStatusScreen extends StatelessWidget {
  final bool isSuccess;
  final String? message;

  const LoginStatusScreen({
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
              isSuccess ? "تم تأكيد الرمز" : "فشل التحقق من الرمز",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (message != null)
              Text(
                message!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            const SizedBox(height: 32),
            Image.asset(
              isSuccess
                  ? 'assets/images/auth_success.jpg'
                  : 'assets/images/auth_failed.jpg',
              height: 150,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (isSuccess) {
                  // TODO: Navigate to Home Screen
                  // مثال:
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                  //   (route) => false,
                  // );
                } else {
                  // عند الفشل، عد إلى شاشة طلب رقم الهاتف (بداية العملية)
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const RequestOtpScreen()), // <-- التعديل هنا
                    (route) => false,
                  );
                }
              },
              child: Text(isSuccess ? "متابعة" : "العودة لتسجيل الدخول"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}