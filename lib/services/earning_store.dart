import '../models/earning.dart';

class EarningStore {
  static final List<WorkerEarning> _earnings = [];

  static List<WorkerEarning> get earnings {
    return List.unmodifiable(
      _earnings,
    );
  }

  static void addEarning(
    WorkerEarning earning,
  ) {
    _earnings.add(earning);
  }

  static WorkerEarning? getEarningById(
    String earningId,
  ) {
    for (final earning in _earnings) {
      if (earning.id == earningId) {
        return earning;
      }
    }

    return null;
  }

  static WorkerEarning? getEarningForAttendance(
    String attendanceId,
  ) {
    for (final earning in _earnings) {
      if (earning.attendance.id ==
          attendanceId) {
        return earning;
      }
    }

    return null;
  }

  static bool hasEarningForAttendance(
    String attendanceId,
  ) {
    return _earnings.any(
      (earning) =>
          earning.attendance.id ==
          attendanceId,
    );
  }

  static List<WorkerEarning>
      getEarningsForWorker(
    String workerName,
  ) {
    return _earnings
        .where(
          (earning) =>
              earning.workerName ==
              workerName,
        )
        .toList();
  }

  static double getTotalEarningsForWorker(
    String workerName,
  ) {
    return getEarningsForWorker(
      workerName,
    ).fold(
      0,
      (
        total,
        earning,
      ) =>
          total + earning.earnedAmount,
    );
  }

  static int getVerifiedEarningDaysForWorker(
    String workerName,
  ) {
    return getEarningsForWorker(
      workerName,
    ).where(
      (earning) =>
          earning.attendance.status ==
          'Verified',
    ).length;
  }
}