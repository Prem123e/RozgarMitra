import 'package:flutter/material.dart';

import '../models/application.dart';
import '../models/job.dart';
import '../services/application_store.dart';
import '../services/job_store.dart';
import '../services/job_translation_service.dart';

class JobListScreen extends StatelessWidget {
  final String selectedLanguage;

  const JobListScreen({
    super.key,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final jobs = JobStore.jobs;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Find Jobs',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: jobs.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];

                  return _buildJobCard(
                    context,
                    job,
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
              Icons.work_outline,
              size: 70,
            ),
            SizedBox(height: 20),
            Text(
              'No jobs available',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'New jobs posted by employers will appear here.',
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

  Widget _buildJobCard(
    BuildContext context,
    Job job,
  ) {
    final translation =
        JobTranslationService.getTranslationForWorker(
      job: job,
      workerLanguage: selectedLanguage,
    );

    final alreadyApplied =
        ApplicationStore.hasAppliedToJob(
      job.id,
    );

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      child: InkWell(
        onTap: () {
          _showJobDetails(
            context,
            job,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.work,
                    size: 35,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      translation.title,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '₹${job.dailyWage.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      translation.location,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    job.workDate,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.engineering,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      translation.requiredSkill,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  alreadyApplied
                      ? 'Already Applied'
                      : 'View Details →',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: alreadyApplied
                        ? Colors.green
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showJobDetails(
    BuildContext context,
    Job job,
  ) {
    final translation =
        JobTranslationService.getTranslationForWorker(
      job: job,
      workerLanguage: selectedLanguage,
    );

    final alreadyApplied =
        ApplicationStore.hasAppliedToJob(
      job.id,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 45,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    translation.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₹${job.dailyWage.toStringAsFixed(0)} / day',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildDetail(
                    Icons.description,
                    'Description',
                    translation.description,
                  ),
                  _buildDetail(
                    Icons.location_on,
                    'Location',
                    translation.location,
                  ),
                  _buildDetail(
                    Icons.calendar_today,
                    'Work Date',
                    job.workDate,
                  ),
                  _buildDetail(
                    Icons.people,
                    'Workers Required',
                    '${job.numberOfWorkers}',
                  ),
                  _buildDetail(
                    Icons.engineering,
                    'Required Skill',
                    translation.requiredSkill,
                  ),
                  _buildDetail(
                    Icons.business,
                    'Employer',
                    job.employerName,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: alreadyApplied
                          ? null
                          : () {
                              _applyForJob(
                                context,
                                job,
                              );
                            },
                      icon: Icon(
                        alreadyApplied
                            ? Icons.check
                            : Icons.send,
                      ),
                      label: Text(
                        alreadyApplied
                            ? 'Already Applied'
                            : 'Apply for Job',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _applyForJob(
    BuildContext context,
    Job job,
  ) {
    final application = JobApplication(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      job: job,
      workerName: 'Demo Worker',
      status: 'Applied',
      appliedAt: DateTime.now(),
    );

    ApplicationStore.addApplication(
      application,
    );

    Navigator.pop(context);

    final translation =
        JobTranslationService.getTranslationForWorker(
      job: job,
      workerLanguage: selectedLanguage,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Application submitted for ${translation.title}',
        ),
      ),
    );
  }

  Widget _buildDetail(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}