// features/police_home/data/models/notification_model.dart
class AppNotification {
  final int id;
  final String type;
  final String createdAt;
  final String description;

  AppNotification({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.description,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'],
      type: json['type'],
      createdAt: json['created_at'],
      description: json['description'],
    );
  }
}