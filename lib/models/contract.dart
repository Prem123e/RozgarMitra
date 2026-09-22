import 'job.dart';

class JobContract {
  final String id;
  final Job job;
  final String workerName;
  final String employerName;
  final double dailyWage;
  final int totalDays;
  final String dailyWorkingHours;
  final String startDate;
  final String endDate;
  final String status;
  final DateTime createdAt;

  JobContract({
    required this.id,
    required this.job,
    required this.workerName,
    required this.employerName,
    required this.dailyWage,
    required this.totalDays,
    required this.dailyWorkingHours,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
  });

  double get totalContractValue {
    return dailyWage * totalDays;
  }

  double get initialEscrowAmount {
    final escrowDays =
        totalDays < 3 ? totalDays : 3;

    return dailyWage * escrowDays;
  }
}