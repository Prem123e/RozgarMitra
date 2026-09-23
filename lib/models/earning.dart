import 'attendance.dart';

class WorkerEarning {
  final String id;
  final AttendanceRecord attendance;
  final String workerName;
  final String date;
  final double dailyWage;
  final double earnedAmount;
  final DateTime createdAt;
  String status;

  WorkerEarning({
    required this.id,
    required this.attendance,
    required this.workerName,
    required this.date,
    required this.dailyWage,
    required this.earnedAmount,
    required this.createdAt,
    required this.status,
  });

  bool get isPayable {
    return status == 'Eligible for Payment';
  }

  void updateStatus(
    String newStatus,
  ) {
    status = newStatus;
  }
}