import 'package:flutter/material.dart';

import '../models/attendance.dart';
import '../models/earning.dart';
import '../services/attendance_store.dart';
import '../services/earning_store.dart';

class AttendanceVerificationScreen extends StatefulWidget {
  final String selectedLanguage;

  const AttendanceVerificationScreen({
    super.key,
    required this.selectedLanguage,
  });

  @override
  State<AttendanceVerificationScreen> createState() =>
      _AttendanceVerificationScreenState();
}

class _AttendanceVerificationScreenState
    extends State<AttendanceVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    final pendingAttendance =
        AttendanceStore.attendanceRecords
            .where(
              (attendance) =>
                  attendance.status ==
                  'Pending Verification',
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance Verification',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: pendingAttendance.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount:
                    pendingAttendance.length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return _buildAttendanceCard(
                    pendingAttendance[index],
                  );
                },
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified_user_outlined,
              size: 72,
            ),
            SizedBox(height: 20),
            Text(
              'No Pending Attendance',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'There are no attendance records waiting for verification.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceCard(
    AttendanceRecord attendance,
  ) {
    final contract = attendance.contract;
    final job = contract.job;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.person,
                  size: 38,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    attendance.workerName,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildStatusBadge(
                  attendance.status,
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Divider(),
            const SizedBox(height: 12),
            _buildDetailRow(
              Icons.work,
              'Job',
              job.originalTitle,
            ),
            _buildDetailRow(
              Icons.location_on,
              'Location',
              job.originalLocation,
            ),
            _buildDetailRow(
              Icons.calendar_today,
              'Attendance Date',
              attendance.date,
            ),
            _buildDetailRow(
              Icons.currency_rupee,
              'Daily Wage',
              '₹${contract.dailyWage.toStringAsFixed(0)}',
            ),
            _buildDetailRow(
              Icons.access_time,
              'Marked At',
              _formatMarkedTime(
                attendance.markedAt,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Employer Action',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _rejectAttendance(
                        attendance,
                      );
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                    label: const Text(
                      'Reject',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _verifyAttendance(
                        attendance,
                      );
                    },
                    icon: const Icon(
                      Icons.verified,
                    ),
                    label: const Text(
                      'Verify',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(20),
        color: Colors.orange.shade100,
      ),
      child: Text(
        status,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.orange.shade800,
          fontSize: 12,
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
          const SizedBox(width: 10),
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
                    text: '$label: ',
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

  void _verifyAttendance(
    AttendanceRecord attendance,
  ) {
    if (attendance.status !=
        'Pending Verification') {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'This attendance has already been processed.',
          ),
        ),
      );
      return;
    }

    attendance.updateStatus(
      'Verified',
    );

    final existingEarning =
        EarningStore.getEarningForAttendance(
      attendance.id,
    );

    if (existingEarning == null) {
      final contract =
          attendance.contract;

      final earning =
          WorkerEarning(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        attendance: attendance,
        workerName:
            attendance.workerName,
        date: attendance.date,
        dailyWage:
            contract.dailyWage,
        earnedAmount:
            contract.dailyWage,
        createdAt: DateTime.now(),
        status:
            'Eligible for Payment',
      );

      EarningStore.addEarning(
        earning,
      );
    }

    setState(() {});

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Attendance verified and earning recorded successfully.',
        ),
      ),
    );
  }

  void _rejectAttendance(
    AttendanceRecord attendance,
  ) {
    if (attendance.status !=
        'Pending Verification') {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'This attendance has already been processed.',
          ),
        ),
      );
      return;
    }

    attendance.updateStatus(
      'Rejected',
    );

    setState(() {});

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Attendance rejected.',
        ),
      ),
    );
  }

  String _formatMarkedTime(
    DateTime value,
  ) {
    final hour = value.hour
        .toString()
        .padLeft(2, '0');

    final minute = value.minute
        .toString()
        .padLeft(2, '0');

    final second = value.second
        .toString()
        .padLeft(2, '0');

    return '$hour:$minute:$second';
  }
}