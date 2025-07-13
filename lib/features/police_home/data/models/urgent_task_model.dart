// features/police_home/data/models/urgent_task_model.dart
class UrgentTask {
  final String type; // 'person_card' or 'vehicle_card'
  final String title;
  final String id;
  final String status;
  final String description;
  final String time;

  UrgentTask({
    required this.type,
    required this.title,
    required this.id,
    required this.status,
    required this.description,
    required this.time,
  });

  // هذه الدالة ستتعامل مع كلتا الحالتين (شخص أو مركبة)
  factory UrgentTask.fromJson(Map<String, dynamic> json) {
    if (json['person_card'] != null) {
      final card = json['person_card'];
      return UrgentTask(
        type: 'person',
        title: card['urgentName'],
        id: card['national_id'],
        status: card['criminal_status'],
        description: card['description'],
        time: card['time'],
      );
    } 
    // يمكنك إضافة حالة المركبة هنا بنفس الطريقة إذا كانت موجودة في الـ API
    // else if (json['vehicle_card'] != null) { ... }
    else {
      // حالة افتراضية أو يمكنك رمي خطأ
      return UrgentTask(type: 'unknown', title: 'مهمة غير معروفة', id: '', status: '', description: '', time: '');
    }
  }
}