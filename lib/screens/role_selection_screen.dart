import 'package:flutter/material.dart';

import '../localization/app_translations.dart';
import 'worker_home_screen.dart';
import 'employer_home_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  final String selectedLanguage;

  const RoleSelectionScreen({
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
            'chooseRole',
          ),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Icon(
                Icons.handshake,
                size: 80,
              ),

              const SizedBox(height: 24),

              Text(
                AppTranslations.get(
                  selectedLanguage,
                  'whoAreYou',
                ),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // WORKER
              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WorkerHomeScreen(
                            selectedLanguage:
                                selectedLanguage,
                          );
                        },
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.person,
                  ),

                  label: Text(
                    AppTranslations.get(
                      selectedLanguage,
                      'worker',
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // EMPLOYER
              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EmployerHomeScreen(
                            selectedLanguage:
                                selectedLanguage,
                          );
                        },
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.business,
                  ),

                  label: Text(
                    AppTranslations.get(
                      selectedLanguage,
                      'employer',
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}