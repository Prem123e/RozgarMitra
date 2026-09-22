import 'package:flutter/material.dart';

import '../localization/app_translations.dart';
import 'employer_applications_screen.dart';
import 'post_job_screen.dart';

class EmployerHomeScreen extends StatelessWidget {
  final String selectedLanguage;

  const EmployerHomeScreen({
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
            'employerHome',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                AppTranslations.get(
                  selectedLanguage,
                  'welcomeEmployer',
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
                  'postJob',
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 30),
              _buildDashboardCard(
                context,
                icon: Icons.add_business,
                title: AppTranslations.get(
                  selectedLanguage,
                  'postJob',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PostJobScreen(
                          selectedLanguage:
                              selectedLanguage,
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildDashboardCard(
                context,
                icon: Icons.work,
                title: AppTranslations.get(
                  selectedLanguage,
                  'myJobs',
                ),
                onTap: () {
                  _showComingSoon(context);
                },
              ),
              const SizedBox(height: 16),
              _buildDashboardCard(
                context,
                icon: Icons.people,
                title: AppTranslations.get(
                  selectedLanguage,
                  'applications',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EmployerApplicationsScreen(
                          selectedLanguage:
                              selectedLanguage,
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildDashboardCard(
                context,
                icon:
                    Icons.account_balance_wallet,
                title: AppTranslations.get(
                  selectedLanguage,
                  'payments',
                ),
                onTap: () {
                  _showComingSoon(context);
                },
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
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
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

  void _showComingSoon(
    BuildContext context,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'This feature will be connected soon.',
        ),
      ),
    );
  }
}