// features/police_home/data/models/activity_model.dart
class Activity {
  final String type; // 'ticket' or 'inspected'
  final String title;
  final String description;
  final String status; // 'تم التحرير' or 'سليمة'
  final String time;

  Activity({
    required this.type,
    required this.title,
    required this.description,
    required this.status,
    required this.time,
  });

  // هذه الدالة ستتعامل مع كلتا الحالتين
  static List<Activity> fromJson(Map<String, dynamic> json) {
    final List<Activity> activities = [];
    
    if (json['activites_card'] != null && json['activites_card']['ticket'] != null) {
      final card = json['activites_card'];
      activities.add(Activity(
        type: 'ticket',
        title: card['ticket'],
        description: card['description'],
        status: 'تم التحرير', // افتراضي بناءً على التصميم
        time: card['time'],
      ));
    }

    if (json['inspected'] != null && json['inspected']['title'] != null) {
      final card = json['inspected'];
       activities.add(Activity(
        type: 'inspected',
        title: card['title'], // افترض وجود حقل title
        description: card['description'],
        status: 'سليمة', // افتراضي بناءً على التصميم
        time: card['time'],
      ));
    }
    
    return activities;
  }
}