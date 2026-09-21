import 'package:flutter/material.dart';

import '../localization/app_translations.dart';

class WorkerHomeScreen extends StatelessWidget {
  final String selectedLanguage;

  const WorkerHomeScreen({
    super.key,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTranslations.get(
            selectedLanguage,
            'workerHome',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTranslations.get(
                  selectedLanguage,
                  'welcomeWorker',
                ),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                AppTranslations.get(
                  selectedLanguage,
                  'findJobs',
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 30),

              _buildDashboardCard(
                context,
                icon: Icons.search,
                title: AppTranslations.get(
                  selectedLanguage,
                  'findJobs',
                ),
              ),

              const SizedBox(height: 16),

              _buildDashboardCard(
                context,
                icon: Icons.description,
                title: AppTranslations.get(
                  selectedLanguage,
                  'myApplications',
                ),
              ),

              const SizedBox(height: 16),

              _buildDashboardCard(
                context,
                icon: Icons.work,
                title: AppTranslations.get(
                  selectedLanguage,
                  'myWork',
                ),
              ),

              const SizedBox(height: 16),

              _buildDashboardCard(
                context,
                icon: Icons.person,
                title: AppTranslations.get(
                  selectedLanguage,
                  'myProfile',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'This feature will be connected soon.',
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                icon,
                size: 42,
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}