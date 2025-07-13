// features/police_home/data/models/statistics_model.dart
class Statistics {
    final int totalVehicles;
    final int totalReports;
    final int totalTickets;
    final int totalInspected;

    Statistics({ required this.totalVehicles, required this.totalReports, required this.totalTickets, required this.totalInspected });

    factory Statistics.fromJson(Map<String, dynamic> json) {
        return Statistics(
            totalVehicles: json['totalVehcile'], // انتبه للاسم في الـ API
            totalReports: json['totalReports'],
            totalTickets: json['totalTickets'],
            totalInspected: json['totalInspected'],
        );
    }
}