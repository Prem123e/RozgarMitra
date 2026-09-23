import 'package:flutter/material.dart';

import '../models/attendance.dart';
import '../models/contract.dart';
import '../services/attendance_store.dart';
import '../services/contract_store.dart';

class MyWorkScreen extends StatefulWidget {
  final String selectedLanguage;

  const MyWorkScreen({
    super.key,
    required this.selectedLanguage,
  });

  @override
  State<MyWorkScreen> createState() =>
      _MyWorkScreenState();
}

class _MyWorkScreenState
    extends State<MyWorkScreen> {
  @override
  Widget build(BuildContext context) {
    final contracts =
        ContractStore.contracts;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Work',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: contracts.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding:
                    const EdgeInsets.all(16),
                itemCount:
                    contracts.length,
                itemBuilder:
                    (context, index) {
                  return _buildWorkCard(
                    contracts[index],
                  );
                },
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding:
            EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.work_history_outlined,
              size: 70,
            ),
            SizedBox(height: 20),
            Text(
              'No active work',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Accepted contracts will appear here.',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkCard(
    JobContract contract,
  ) {
    final today = _formatToday();

    final attendance =
        AttendanceStore
            .getAttendanceForContractAndDate(
      contractId: contract.id,
      date: today,
    );

    final todayDate = _dateOnly(
      DateTime.now(),
    );

    final startDate =
        _parseContractDate(
      contract.startDate,
    );

    final endDate =
        _parseContractDate(
      contract.endDate,
    );

    final isBeforeContract =
        startDate != null &&
            todayDate.isBefore(startDate);

    final isAfterContract =
        endDate != null &&
            todayDate.isAfter(endDate);

    final isWithinContract =
        !isBeforeContract &&
            !isAfterContract;

    final contractDayNumber =
        isWithinContract &&
                startDate != null
            ? todayDate
                    .difference(startDate)
                    .inDays +
                1
            : null;

    return Card(
      elevation: 3,
      margin:
          const EdgeInsets.only(
        bottom: 16,
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.work,
                  size: 38,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    contract
                        .job
                        .originalTitle,
                    style:
                        const TextStyle(
                      fontSize: 21,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
                _buildStatusBadge(
                  contract.status,
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            _buildDetailRow(
              Icons.location_on,
              'Location',
              contract
                  .job
                  .originalLocation,
            ),
            _buildDetailRow(
              Icons.currency_rupee,
              'Daily Wage',
              '₹${contract.dailyWage.toStringAsFixed(0)}',
            ),
            _buildDetailRow(
              Icons.calendar_today,
              'Start Date',
              contract.startDate,
            ),
            _buildDetailRow(
              Icons.event_available,
              'End Date',
              contract.endDate,
            ),
            _buildDetailRow(
              Icons.today,
              'Contract Days',
              contract.totalDays
                  .toString(),
            ),
            const Divider(
              height: 28,
            ),
            const Text(
              'Today\'s Attendance',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _buildContractDateStatus(
              isBeforeContract:
                  isBeforeContract,
              isAfterContract:
                  isAfterContract,
              isWithinContract:
                  isWithinContract,
              contractDayNumber:
                  contractDayNumber,
              startDate:
                  startDate,
              endDate:
                  endDate,
            ),
            const SizedBox(
              height: 14,
            ),
            _buildAttendanceStatus(
              attendance,
            ),
            const SizedBox(
              height: 14,
            ),
            if (attendance == null &&
                isWithinContract)
              SizedBox(
                width:
                    double.infinity,
                child:
                    ElevatedButton.icon(
                  onPressed: () {
                    _markAttendance(
                      contract,
                    );
                  },
                  icon: const Icon(
                    Icons.check_circle,
                  ),
                  label: Text(
                    'Mark Today\'s Attendance'
                    '${contractDayNumber != null ? ' - Day $contractDayNumber' : ''}',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContractDateStatus({
    required bool isBeforeContract,
    required bool isAfterContract,
    required bool isWithinContract,
    required int? contractDayNumber,
    required DateTime? startDate,
    required DateTime? endDate,
  }) {
    if (isBeforeContract) {
      return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.all(14),
        decoration:
            BoxDecoration(
          borderRadius:
              BorderRadius.circular(10),
          color:
              Colors.orange.shade50,
        ),
        child: const Row(
          children: [
            Icon(
              Icons.schedule,
              color: Colors.orange,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Work has not started yet. Attendance can be marked from the contract start date.',
                style: TextStyle(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (isAfterContract) {
      return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.all(14),
        decoration:
            BoxDecoration(
          borderRadius:
              BorderRadius.circular(10),
          color:
              Colors.red.shade50,
        ),
        child: const Row(
          children: [
            Icon(
              Icons.event_busy,
              color: Colors.red,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'This contract has ended. Attendance can no longer be marked.',
                style: TextStyle(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (isWithinContract &&
        contractDayNumber != null) {
      return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.all(14),
        decoration:
            BoxDecoration(
          borderRadius:
              BorderRadius.circular(10),
          color:
              Colors.green.shade50,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.today,
              color: Colors.green,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Today is Contract Day $contractDayNumber.',
                style: const TextStyle(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildAttendanceStatus(
    AttendanceRecord? attendance,
  ) {
    if (attendance == null) {
      return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.all(14),
        decoration:
            BoxDecoration(
          borderRadius:
              BorderRadius.circular(10),
          color:
              Colors.orange.shade50,
        ),
        child: const Row(
          children: [
            Icon(
              Icons.pending_actions,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Not marked yet.',
                style: TextStyle(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (attendance.status ==
        'Verified') {
      return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.all(14),
        decoration:
            BoxDecoration(
          borderRadius:
              BorderRadius.circular(10),
          color:
              Colors.green.shade50,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.verified,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Attendance verified by employer. Contract Day ${attendance.contractDayNumber}.',
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (attendance.status ==
        'Rejected') {
      return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.all(14),
        decoration:
            BoxDecoration(
          borderRadius:
              BorderRadius.circular(10),
          color:
              Colors.red.shade50,
        ),
        child: const Row(
          children: [
            Icon(
              Icons.cancel,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Attendance was rejected by employer.',
                style: TextStyle(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(14),
      decoration:
          BoxDecoration(
        borderRadius:
            BorderRadius.circular(10),
        color:
            Colors.blue.shade50,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.hourglass_top,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Attendance marked for Contract Day ${attendance.contractDayNumber}. Waiting for employer verification.',
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _markAttendance(
    JobContract contract,
  ) {
    final todayDate = _dateOnly(
      DateTime.now(),
    );

    final startDate =
        _parseContractDate(
      contract.startDate,
    );

    final endDate =
        _parseContractDate(
      contract.endDate,
    );

    if (startDate == null ||
        endDate == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to determine the contract dates.',
          ),
        ),
      );
      return;
    }

    if (todayDate.isBefore(
      startDate,
    )) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Work starts on ${contract.startDate}. Attendance cannot be marked before the start date.',
          ),
        ),
      );
      return;
    }

    if (todayDate.isAfter(
      endDate,
    )) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'This contract ended on ${contract.endDate}. Attendance cannot be marked now.',
          ),
        ),
      );
      return;
    }

    final today =
        _formatDate(todayDate);

    final existingAttendance =
        AttendanceStore
            .getAttendanceForContractAndDate(
      contractId: contract.id,
      date: today,
    );

    if (existingAttendance != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Attendance has already been marked for today.',
          ),
        ),
      );
      return;
    }

    final contractDayNumber =
        todayDate
                .difference(startDate)
                .inDays +
            1;

    final attendance =
        AttendanceRecord(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      contract: contract,
      workerName:
          contract.workerName,
      date: today,
      contractDayNumber:
          contractDayNumber,
      status:
          'Pending Verification',
      markedAt: DateTime.now(),
    );

    setState(() {
      AttendanceStore.addAttendance(
        attendance,
      );
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          'Attendance marked for Contract Day $contractDayNumber. Waiting for employer verification.',
        ),
      ),
    );
  }

  DateTime? _parseContractDate(
    String value,
  ) {
    final parts =
        value.trim().split('/');

    if (parts.length != 3) {
      return null;
    }

    final day =
        int.tryParse(parts[0]);

    final month =
        int.tryParse(parts[1]);

    final yearValue =
        int.tryParse(parts[2]);

    if (day == null ||
        month == null ||
        yearValue == null) {
      return null;
    }

    final year = yearValue < 100
        ? 2000 + yearValue
        : yearValue;

    final parsed =
        DateTime(
      year,
      month,
      day,
    );

    if (parsed.year != year ||
        parsed.month != month ||
        parsed.day != day) {
      return null;
    }

    return _dateOnly(parsed);
  }

  DateTime _dateOnly(
    DateTime value,
  ) {
    return DateTime(
      value.year,
      value.month,
      value.day,
    );
  }

  String _formatToday() {
    return _formatDate(
      _dateOnly(
        DateTime.now(),
      ),
    );
  }

  String _formatDate(
    DateTime value,
  ) {
    final day =
        value.day
            .toString()
            .padLeft(2, '0');

    final month =
        value.month
            .toString()
            .padLeft(2, '0');

    final year =
        value.year.toString();

    return '$day/$month/$year';
  }

  Widget _buildStatusBadge(
    String status,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration:
          BoxDecoration(
        borderRadius:
            BorderRadius.circular(20),
        color:
            Colors.green.shade100,
      ),
      child: Text(
        status,
        style: TextStyle(
          fontWeight:
              FontWeight.bold,
          color:
              Colors.green.shade800,
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text:
                        '$label: ',
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: value,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}