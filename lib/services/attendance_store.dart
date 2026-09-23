import '../models/attendance.dart';

class AttendanceStore {
  static final List<AttendanceRecord> _attendanceRecords = [];

  static List<AttendanceRecord> get attendanceRecords {
    return List.unmodifiable(
      _attendanceRecords,
    );
  }

  static void addAttendance(
    AttendanceRecord attendance,
  ) {
    _attendanceRecords.add(attendance);
  }

  static AttendanceRecord? getAttendanceById(
    String attendanceId,
  ) {
    for (final attendance
        in _attendanceRecords) {
      if (attendance.id == attendanceId) {
        return attendance;
      }
    }

    return null;
  }

  static AttendanceRecord? getAttendanceForContractAndDate({
    required String contractId,
    required String date,
  }) {
    for (final attendance
        in _attendanceRecords) {
      if (attendance.contract.id ==
              contractId &&
          attendance.date == date) {
        return attendance;
      }
    }

    return null;
  }

  static bool hasAttendanceForContractAndDate({
    required String contractId,
    required String date,
  }) {
    return _attendanceRecords.any(
      (attendance) =>
          attendance.contract.id ==
              contractId &&
          attendance.date == date,
    );
  }

  static List<AttendanceRecord>
      getAttendanceForContract(
    String contractId,
  ) {
    return _attendanceRecords
        .where(
          (attendance) =>
              attendance.contract.id ==
              contractId,
        )
        .toList();
  }

  static List<AttendanceRecord>
      getAttendanceForWorker(
    String workerName,
  ) {
    return _attendanceRecords
        .where(
          (attendance) =>
              attendance.workerName ==
              workerName,
        )
        .toList();
  }
}