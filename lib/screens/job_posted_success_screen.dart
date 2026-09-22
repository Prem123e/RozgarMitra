import 'package:flutter/material.dart';

import '../models/job.dart';

class JobPostedSuccessScreen extends StatelessWidget {
  final Job job;

  const JobPostedSuccessScreen({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Posted'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade100,
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 70,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Job Posted Successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Your job is now available for eligible workers.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Job Details',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      _buildDetailRow(
                        Icons.work,
                        'Job Title',
                        job.title,
                      ),

                      _buildDetailRow(
                        Icons.description,
                        'Description',
                        job.description,
                      ),

                      _buildDetailRow(
                        Icons.location_on,
                        'Location',
                        job.location,
                      ),

                      _buildDetailRow(
                        Icons.currency_rupee,
                        'Daily Wage',
                        '₹${job.dailyWage.toStringAsFixed(0)}',
                      ),

                      _buildDetailRow(
                        Icons.people,
                        'Workers Required',
                        '${job.numberOfWorkers}',
                      ),

                      _buildDetailRow(
                        Icons.calendar_today,
                        'Work Date',
                        job.workDate,
                      ),

                      _buildDetailRow(
                        Icons.engineering,
                        'Required Skill',
                        job.requiredSkill,
                      ),

                      _buildDetailRow(
                        Icons.verified,
                        'Status',
                        job.status,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.home,
                  ),
                  label: const Text(
                    'Back to Employer Home',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
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
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 25,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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