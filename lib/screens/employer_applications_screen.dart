import 'package:flutter/material.dart';

import '../models/application.dart';
import '../services/application_store.dart';
import '../services/job_store.dart';
import '../services/job_translation_service.dart';

class EmployerApplicationsScreen extends StatefulWidget {
  final String selectedLanguage;

  const EmployerApplicationsScreen({
    super.key,
    required this.selectedLanguage,
  });

  @override
  State<EmployerApplicationsScreen> createState() =>
      _EmployerApplicationsScreenState();
}

class _EmployerApplicationsScreenState
    extends State<EmployerApplicationsScreen> {
  @override
  Widget build(BuildContext context) {
    final applications = ApplicationStore.applications;

    final employerJobIds = JobStore.jobs
        .map((job) => job.id)
        .toSet();

    final employerApplications = applications
        .where(
          (application) =>
              employerJobIds.contains(application.job.id),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Applications',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: employerApplications.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: employerApplications.length,
                itemBuilder: (context, index) {
                  return _buildApplicationCard(
                    employerApplications[index],
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 70,
            ),
            SizedBox(height: 20),
            Text(
              'No applications yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Applications from workers will appear here.',
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

  Widget _buildApplicationCard(
    JobApplication application,
  ) {
    final job = application.job;

    final translation =
        JobTranslationService.getTranslationForWorker(
      job: job,
      workerLanguage: widget.selectedLanguage,
    );

    final isApplied =
        application.status == 'Applied';

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.person,
                  size: 40,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        application.workerName,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Worker Application',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(
                  application.status,
                ),
              ],
            ),
            const SizedBox(height: 18),
            _buildDetailRow(
              Icons.work,
              'Job',
              translation.title,
            ),
            _buildDetailRow(
              Icons.location_on,
              'Location',
              translation.location,
            ),
            _buildDetailRow(
              Icons.currency_rupee,
              'Daily Wage',
              '₹${job.dailyWage.toStringAsFixed(0)}',
            ),
            _buildDetailRow(
              Icons.calendar_today,
              'Work Date',
              job.workDate,
            ),
            _buildDetailRow(
              Icons.engineering,
              'Required Skill',
              translation.requiredSkill,
            ),
            _buildDetailRow(
              Icons.access_time,
              'Applied',
              _formatDate(
                application.appliedAt,
              ),
            ),
            if (isApplied) ...[
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              const Text(
                'Manage Application',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _updateApplicationStatus(
                          application,
                          'Rejected',
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
                        _updateApplicationStatus(
                          application,
                          'Accepted',
                        );
                      },
                      icon: const Icon(
                        Icons.check,
                      ),
                      label: const Text(
                        'Accept',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
    String status,
  ) {
    Color backgroundColor;
    Color textColor;

    if (status == 'Accepted') {
      backgroundColor = Colors.green.shade100;
      textColor = Colors.green.shade800;
    } else if (status == 'Rejected') {
      backgroundColor = Colors.red.shade100;
      textColor = Colors.red.shade800;
    } else {
      backgroundColor = Colors.orange.shade100;
      textColor = Colors.orange.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
      ),
      child: Text(
        status,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
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
      padding: const EdgeInsets.only(
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
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
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

  void _updateApplicationStatus(
    JobApplication application,
    String newStatus,
  ) {
    setState(() {
      application.updateStatus(
        newStatus,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Application ${newStatus.toLowerCase()} successfully.',
        ),
      ),
    );
  }

  String _formatDate(
    DateTime date,
  ) {
    final day =
        date.day.toString().padLeft(2, '0');
    final month =
        date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day-$month-$year';
  }
}