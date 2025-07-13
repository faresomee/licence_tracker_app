// features/onboarding/presentation/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:licence_tracker_app/features/auth/presentation/screens/login_screen.dart';
import 'package:licence_tracker_app/features/auth/presentation/screens/request_otp_screen.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // قائمة محتوى الصفحات التعريفية
  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/logo.png",
      "title": "مرحبًا بك في لبوت",
      "description":
          "تطبيقنا يساعدك في التعرف على المركبات المشبوهة بسرعة وأمان باستخدام تقنيات الذكاء الاصطناعي والتعرف على لوحات السيارات.",
    },
    {
      "image": "assets/images/onboarding_car.png",
      "title": "التعرف على اللوحات",
      "description":
          "استخدم الكاميرا لمسح لوحات المركبات ومقارنتها مع قاعدة البيانات لمعرفة الحالة الأمنية لكل مركبة.",
    },
    {
      "image": "assets/images/onboarding_police.png",
      "title": "التنبيهات الفورية",
      "description":
          "سيتم تنبيهك فورًا عند اكتشاف مركبة مطلوبة، مسروقة، أو مشبوهة، مع عرض التفاصيل اللازمة.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onboardingData.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingPageWidget(
                      data: _onboardingData[index],
                      isFirstPage: index == 0,
                    );
                  },
                ),
              ),
              // مؤشر الصفحات (النقاط)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => buildDot(index, context),
                ),
              ),
              const SizedBox(height: 40),
              // الزر السفلي
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _onboardingData.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // الانتقال إلى شاشة طلب رقم الهاتف
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) =>
                                const RequestOtpScreen()), // <-- التعديل هنا
                      );
                    }
                  },
                  child: Text(
                    _currentPage == 0
                        ? "ابدأ الآن"
                        : _currentPage < _onboardingData.length - 1
                            ? "متابعة"
                            : "سجل الآن",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ويدجت لبناء النقطة في مؤشر الصفحات
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: _currentPage == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentPage == index
            ? Theme.of(context).primaryColor
            : const Color(0xFFD8D8D8),
      ),
    );
  }
}

// ويدجت مخصص لعرض محتوى كل صفحة تعريفية
class OnboardingPageWidget extends StatelessWidget {
  final Map<String, String> data;
  final bool isFirstPage;

  const OnboardingPageWidget({
    Key? key,
    required this.data,
    this.isFirstPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isFirstPage) const Spacer(flex: 2),
        Image.asset(data['image']!),
        if (isFirstPage) const Spacer(flex: 1),
        const SizedBox(height: 40),
        Text(
          data['title']!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF003C71), // لون أزرق داكن
          ),
        ),
        const SizedBox(height: 15),
        Text(
          data['description']!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            height: 1.5,
          ),
        ),
        if (isFirstPage) const Spacer(flex: 3),
      ],
    );
  }
}
