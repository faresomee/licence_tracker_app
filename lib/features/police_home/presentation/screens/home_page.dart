// features/police_home/presentation/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:licence_tracker_app/core/api/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// قم بإنشاء هذه الصفحات لاحقًا
// import 'notifications_page.dart'; 
// import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> _homeDataFuture;

  @override
  void initState() {
    super.initState();
    _homeDataFuture = _fetchHomeData();
  }

  Future<Map<String, dynamic>> _fetchHomeData() async {
    final apiClient = ApiClient().dio;
    try {
      final responses = await Future.wait([
        apiClient.get('/police/my-details'),
        apiClient.get('/police/statistics'),
        apiClient.get('/police/urgent'),
        apiClient.get('/police/activites'),
      ]);

      return {
        'details': responses[0].data,
        'statistics': responses[1].data,
        'urgent': responses[2].data,
        'activities': responses[3].data,
      };
    } catch (e) {
      throw Exception('Failed to load home data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _homeDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('No data found'));
        }

        final data = snapshot.data!;
        
        return Scaffold(
          backgroundColor: const Color(0xFFF0F4F8), // لون خلفية فاتح
          body: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _homeDataFuture = _fetchHomeData();
              });
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileHeader(context, data['details']['data']),
                  const SizedBox(height: 24),
                  _buildStatisticsSection(data['statistics']),
                  const SizedBox(height: 24),
                  _buildUrgentTasksSection(data['urgent']['data']),
                  const SizedBox(height: 24),
                  _buildRecentActivitySection(data['activities']['data']),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(BuildContext context, Map<String, dynamic> details) {
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    final imageUrl = '$baseUrl/uploads/images/police_users/${details['img_profile']}';
    
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
      decoration: const BoxDecoration(
        color: Color(0xFF305FA2),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () { /* Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage())); */ }, icon: const Icon(Iconsax.setting_2, color: Colors.white)),
              const Text('وزارة الداخلية', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(onPressed: () { /* Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationsPage())); */ }, icon: const Icon(Iconsax.notification, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(imageUrl),
                    backgroundColor: Colors.white24,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('نشط', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(details['name'] ?? 'اسم الضابط', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('${details['rank_id'] ?? ''} ・ رقم: ${details['military_id'] ?? ''}', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                    Text('${details['department'] ?? ''} ・ ${details['city'] ?? ''}', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection(Map<String, dynamic> stats) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('إحصائيات اليوم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF305FA2))),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2 / 1,
            children: [
              _StatCard(title: 'مركبات تم فحصها', value: stats['totalInspected'].toString(), icon: Iconsax.search_normal, color: const Color(0xFF305FA2)),
              _StatCard(title: 'مخالفات مسجلة', value: stats['totalTickets'].toString(), icon: Iconsax.ticket, color: const Color(0xFFFF9A4A)),
              _StatCard(title: 'مركبات مطلوبة', value: stats['totalVehicles'].toString(), icon: Iconsax.warning_2, color: const Color(0xFFDC2626)),
              _StatCard(title: 'تقارير مسجلة', value: stats['totalReports'].toString(), icon: Iconsax.document_text, color: const Color(0xFF4ADE80)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildUrgentTasksSection(Map<String, dynamic> urgentData) {
     if (urgentData.isEmpty || urgentData['person_card'] == null) {
        return const SizedBox.shrink(); // لا تعرض أي شيء إذا كانت البيانات فارغة
    }
    final personCard = urgentData['person_card'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: const Text('مهام عاجلة', style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              const Text('مهام عاجلة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF305FA2))),
            ],
          ),
          const SizedBox(height: 12),
          _UrgentTaskCard(
            title: personCard['urgentName'] ?? 'مهمة عاجلة',
            subtitle: personCard['national_id'] ?? 'تفاصيل',
            description: personCard['description'] ?? 'لا يوجد وصف',
            time: personCard['time'] ?? '',
          ),
          // يمكنك إضافة المزيد من الكروت هنا إذا كان الـ API يرجع قائمة
        ],
      ),
    );
  }

  Widget _buildRecentActivitySection(Map<String, dynamic> activityData) {
     if (activityData.isEmpty || activityData['activites_card'] == null) {
        return const SizedBox.shrink();
    }
    final ticket = activityData['activites_card'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('النشاط الحديث', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF305FA2))),
          const SizedBox(height: 12),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _ActivityTile(
                    icon: Iconsax.ticket_star,
                    iconColor: Colors.orange,
                    title: ticket['ticket'] ?? 'نشاط غير معروف',
                    subtitle: ticket['description'] ?? '',
                    status: ticket['action'] ?? '',
                    time: ticket['time'] ?? '',
                  ),
                  // أضف المزيد من الأنشطة هنا
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ============== ويدجتس مساعدة ==============

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
              Text(value, style: TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: Colors.white, size: 20),
          )
        ],
      ),
    );
  }
}

class _UrgentTaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String time;

  const _UrgentTaskCard({required this.title, required this.subtitle, required this.description, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Iconsax.warning_2, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
              child: Text(description, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String status;
  final String time;

  const _ActivityTile({required this.icon, required this.iconColor, required this.title, required this.subtitle, required this.status, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
           Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: iconColor, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
               Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
               const SizedBox(height: 4),
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                 decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                 child: Text(status, style: TextStyle(color: iconColor, fontSize: 10, fontWeight: FontWeight.bold)),
               )
            ],
          )
        ],
      ),
    );
  }
}