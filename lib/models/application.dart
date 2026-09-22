import 'job.dart';

class JobApplication {
  final String id;
  final Job job;
  final String workerName;
  String status;
  final DateTime appliedAt;
  DateTime? statusUpdatedAt;

  JobApplication({
    required this.id,
    required this.job,
    required this.workerName,
    required this.status,
    required this.appliedAt,
    this.statusUpdatedAt,
  });

  void updateStatus(
    String newStatus,
  ) {
    status = newStatus;
    statusUpdatedAt = DateTime.now();
  }
}