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
              crossAxisAlignment: CrossAxisAlignment.start,
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
    TextInputType keyboardType = TextInputType.text,
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
        if (value == null || value.trim().isEmpty) {
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

    final job = Job(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      originalLanguage: widget.selectedLanguage,
      originalTitle: jobTitleController.text.trim(),
      originalDescription: descriptionController.text.trim(),
      originalLocation: locationController.text.trim(),
      originalRequiredSkill: skillController.text.trim(),
      translations: {
        widget.selectedLanguage: JobTranslation(
          title: jobTitleController.text.trim(),
          description: descriptionController.text.trim(),
          location: locationController.text.trim(),
          requiredSkill: skillController.text.trim(),
        ),
      },
      dailyWage: double.parse(
        wageController.text.trim(),
      ),
      numberOfWorkers: int.parse(
        workersController.text.trim(),
      ),
      workDate: dateController.text.trim(),
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
}