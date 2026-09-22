import 'job.dart';

class JobApplication {
  final String id;
  final Job job;
  final String workerName;
  final String status;
  final DateTime appliedAt;

  JobApplication({
    required this.id,
    required this.job,
    required this.workerName,
    required this.status,
    required this.appliedAt,
  });
}