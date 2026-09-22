import 'job.dart';

class JobContract {
  final String id;
  final Job job;
  final String workerName;
  final String employerName;
  final double dailyWage;
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
    required this.dailyWorkingHours,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
  });

  int get totalDays {
    final start = _parseDate(startDate);
    final end = _parseDate(endDate);

    if (start == null || end == null) {
      return 1;
    }

    final difference = end.difference(start).inDays;

    if (difference < 0) {
      return 0;
    }

    return difference + 1;
  }

  double get totalContractValue {
    return dailyWage * totalDays;
  }

  double get initialEscrowAmount {
    final escrowDays =
        totalDays < 3 ? totalDays : 3;

    return dailyWage * escrowDays;
  }

  DateTime? _parseDate(String value) {
    final parts = value.trim().split('/');

    if (parts.length != 3) {
      return null;
    }

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final yearValue = int.tryParse(parts[2]);

    if (day == null ||
        month == null ||
        yearValue == null) {
      return null;
    }

    final year = yearValue < 100
        ? 2000 + yearValue
        : yearValue;

    try {
      return DateTime(
        year,
        month,
        day,
      );
    } catch (_) {
      return null;
    }
  }
}