// main.dart
import 'package:flutter/material.dart';
import 'package:licence_tracker_app/features/onboarding/presentation/screens/splash_screen.dart'; // تأكد من المسار الصحيح
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // <-- أضف هذا

// main.dart
Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // اطبع الخطأ لتعرف ما هي المشكلة بالضبط
    print("Error loading .env file: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LPOT App',
      // لدعم اللغة العربية بشكل صحيح
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''), // Arabic
      ],
      locale: const Locale('ar', ''),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily:
            'Cairo', // يمكنك استخدام أي خط عربي تفضله (مثل Tajawal, Almarai)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0056A0), // لون الزر الأزرق
            foregroundColor: Colors.white, // لون النص داخل الزر
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
