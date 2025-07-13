// features/onboarding/presentation/screens/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart'; // سنقوم بإنشاء هذا الملف في الخطوة التالية

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // الانتقال إلى الشاشة التالية بعد 3 ثوانٍ
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const OnboardingScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}