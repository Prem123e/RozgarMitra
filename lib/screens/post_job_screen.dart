import 'package:flutter/material.dart';

import '../localization/app_translations.dart';
import '../models/job.dart';
import '../services/job_store.dart';
import 'job_posted_success_screen.dart';

class PostJobScreen extends StatefulWidget {
  final String selectedLanguage;

  const PostJobScreen({
    super.key,
    required this.selectedLanguage,
  });

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController jobTitleController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  final TextEditingController locationController =
      TextEditingController();

  final TextEditingController wageController =
      TextEditingController();

  final TextEditingController workersController =
      TextEditingController();

  final TextEditingController dateController =
      TextEditingController();

  final TextEditingController endDateController =
      TextEditingController();

  final TextEditingController skillController =
      TextEditingController();

  @override
  void dispose() {
    jobTitleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    wageController.dispose();
    workersController.dispose();
    dateController.dispose();
    endDateController.dispose();
    skillController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final language = widget.selectedLanguage;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTranslations.get(
            language,
            'postJob',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  AppTranslations.get(
                    language,
                    'postJob',
                  ),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppTranslations.get(
                    language,
                    'enterJobDetails',
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(
                  controller: jobTitleController,
                  label: AppTranslations.get(
                    language,
                    'jobTitle',
                  ),
                  hint: AppTranslations.get(
                    language,
                    'jobTitleHint',
                  ),
                  icon: Icons.work,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: descriptionController,
                  label: AppTranslations.get(
                    language,
                    'jobDescription',
                  ),
                  hint: AppTranslations.get(
                    language,
                    'jobDescriptionHint',
                  ),
                  icon: Icons.description,
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: locationController,
                  label: AppTranslations.get(
                    language,
                    'workLocation',
                  ),
                  hint: AppTranslations.get(
                    language,
                    'workLocationHint',
                  ),
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: wageController,
                  label: AppTranslations.get(
                    language,
                    'dailyWage',
                  ),
                  hint: AppTranslations.get(
                    language,
                    'dailyWageHint',
                  ),
                  icon: Icons.currency_rupee,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: workersController,
                  label: AppTranslations.get(
                    language,
                    'numberOfWorkers',
                  ),
                  hint: AppTranslations.get(
                    language,
                    'workersHint',
                  ),
                  icon: Icons.people,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: dateController,
                  label: AppTranslations.get(
                    language,
                    'workDate',
                  ),
                  hint: AppTranslations.get(
                    language,
                    'workDateHint',
                  ),
                  icon: Icons.calendar_today,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: endDateController,
                  label: 'Contract End Date',
                  hint: 'DD/MM/YY',
                  icon: Icons.event_available,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: skillController,
                  label: AppTranslations.get(
                    language,
                    'requiredSkill',
                  ),
                  hint: AppTranslations.get(
                    language,
                    'skillHint',
                  ),
                  icon: Icons.engineering,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: _publishJob,
                    icon: const Icon(
                      Icons.publish,
                    ),
                    label: Text(
                      AppTranslations.get(
                        language,
                        'publishJob',
                      ),
                      style: const TextStyle(
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
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType =
        TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null ||
            value.trim().isEmpty) {
          return '${AppTranslations.get(
            widget.selectedLanguage,
            'pleaseEnter',
          )} $label';
        }

        return null;
      },
    );
  }

  void _publishJob() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final dailyWage = double.tryParse(
      wageController.text.trim(),
    );

    final numberOfWorkers = int.tryParse(
      workersController.text.trim(),
    );

    if (dailyWage == null ||
        dailyWage <= 0) {
      _showError(
        'Please enter a valid daily wage.',
      );
      return;
    }

    if (numberOfWorkers == null ||
        numberOfWorkers <= 0) {
      _showError(
        'Please enter a valid number of workers.',
      );
      return;
    }

    final startDate = _parseDate(
      dateController.text.trim(),
    );

    final endDate = _parseDate(
      endDateController.text.trim(),
    );

    if (startDate == null ||
        endDate == null) {
      _showError(
        'Please enter valid dates in DD/MM/YY format.',
      );
      return;
    }

    if (endDate.isBefore(startDate)) {
      _showError(
        'Contract end date cannot be before the start date.',
      );
      return;
    }

    final job = Job(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      originalLanguage:
          widget.selectedLanguage,
      originalTitle:
          jobTitleController.text.trim(),
      originalDescription:
          descriptionController.text.trim(),
      originalLocation:
          locationController.text.trim(),
      originalRequiredSkill:
          skillController.text.trim(),
      translations: {
        widget.selectedLanguage:
            JobTranslation(
          title:
              jobTitleController.text.trim(),
          description:
              descriptionController.text.trim(),
          location:
              locationController.text.trim(),
          requiredSkill:
              skillController.text.trim(),
        ),
      },
      dailyWage: dailyWage,
      numberOfWorkers: numberOfWorkers,
      workDate:
          dateController.text.trim(),
      contractEndDate:
          endDateController.text.trim(),
      employerName: 'Demo Employer',
      status: 'Published',
      createdAt: DateTime.now(),
    );

    JobStore.addJob(job);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return JobPostedSuccessScreen(
            job: job,
          );
        },
      ),
    );
  }

  DateTime? _parseDate(
    String value,
  ) {
    final parts = value.split('/');

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

    final date = DateTime(
      year,
      month,
      day,
    );

    if (date.year != year ||
        date.month != month ||
        date.day != day) {
      return null;
    }

    return date;
  }

  void _showError(
    String message,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}