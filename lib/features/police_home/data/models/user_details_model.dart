// features/police_home/data/models/user_details_model.dart
// (استخدم Freezed لتوليد هذا الكود أو اكتبه يدويًا)
class UserDetails {
    final int id;
    final String name;
    final String rankId;
    final String department;
    final String city;
    final String imgProfile;
    
    UserDetails({ required this.id, required this.name, required this.rankId, required this.department, required this.city, required this.imgProfile });

    factory UserDetails.fromJson(Map<String, dynamic> json) {
        return UserDetails(
            id: json['data']['id'],
            name: json['data']['name'],
            rankId: json['data']['rank_id'],
            department: json['data']['department'],
            city: json['data']['city'],
            imgProfile: json['data']['img_profile'],
        );
    }
}