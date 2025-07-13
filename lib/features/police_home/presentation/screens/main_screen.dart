// features/police_home/presentation/screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:licence_tracker_app/features/police_home/presentation/screens/home_page.dart';
// استيراد باقي الصفحات
// import 'violations_page.dart';
// import 'reports_page.dart';
// import 'search_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 4; // نبدأ من اليمين (الرئيسية)

  // قائمة الصفحات
  static const List<Widget> _pages = <Widget>[
    Text('Search Page'), // 0: البحث اليدوي
    Text('Reports Page'), // 1: التقارير
    SizedBox.shrink(), // 2: زر الكاميرا الأوسط
    Text('Violations Page'), // 3: المخالفات
    HomePage(), // 4: الرئيسية
  ];

  void _onItemTapped(int index) {
    if (index == 2) return; // لا تفعل شيئًا عند الضغط على الزر الأوسط
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: buildBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () { /* TODO: open camera */ },
        backgroundColor: const Color(0xFF305FA2),
        elevation: 4.0,
        child: const Icon(Iconsax.camera, color: Colors.white, size: 30),
      ),
    );
  }

  Widget buildBottomNav() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Directionality(
        textDirection: TextDirection.rtl, // لترتيب الأيقونات من اليمين لليسار
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(icon: Iconsax.home, label: 'الرئيسية', index: 4),
            _buildNavItem(icon: Iconsax.ticket, label: 'المخالفات', index: 3),
            const SizedBox(width: 40), // مساحة للزر العائم
            _buildNavItem(icon: Iconsax.document_text, label: 'التقارير', index: 1),
            _buildNavItem(icon: Iconsax.search_normal, label: 'البحث', index: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: isSelected ? const Color(0xFF305FA2) : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF305FA2) : Colors.grey,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}