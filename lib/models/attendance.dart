import 'contract.dart';

class AttendanceRecord {
  final String id;
  final JobContract contract;
  final String workerName;
  final String date;
  String status;
  final DateTime markedAt;
  DateTime? verifiedAt;

  AttendanceRecord({
    required this.id,
    required this.contract,
    required this.workerName,
    required this.date,
    required this.status,
    required this.markedAt,
    this.verifiedAt,
  });

  void updateStatus(
    String newStatus,
  ) {
    status = newStatus;

    if (newStatus == 'Verified') {
      verifiedAt = DateTime.now();
    }
  }
}