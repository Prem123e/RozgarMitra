import 'package:flutter/material.dart';

import '../localization/app_translations.dart';
import 'role_selection_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState
    extends State<LanguageSelectionScreen> {
  String? selectedLanguage;

  final List<String> languages = [
    'English',
    'हिन्दी',
    'অসমীয়া',
    'বাংলা',
    'बड़ो',
    'डोगरी',
    'ગુજરાતી',
    'ಕನ್ನಡ',
    'کٲشُر / कॉशुर',
    'कोंकणी',
    'मैथिली',
    'മലയാളം',
    'মৈতৈলোন্',
    'मराठी',
    'नेपाली',
    'ଓଡ଼ିଆ',
    'ਪੰਜਾਬੀ',
    'संस्कृतम्',
    'ᱥᱟᱱᱛᱟᱲᱤ',
    'سنڌي',
    'தமிழ்',
    'తెలుగు',
    'اردو',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RozgarMitra'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Icon(
                Icons.language,
                size: 70,
              ),

              const SizedBox(height: 20),

              const Text(
                'Choose your language',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              const Text(
                'अपनी भाषा चुनें • మీ భాషను ఎంచుకోండి',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: RadioGroup<String>(
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value;
                    });
                  },
                  child: ListView.builder(
                    itemCount: languages.length,
                    itemBuilder: (context, index) {
                      final language = languages[index];

                      return Card(
                        child: RadioListTile<String>(
                          title: Text(
                            language,
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          value: language,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedLanguage == null
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RoleSelectionScreen(
                                  selectedLanguage: selectedLanguage!,
                                );
                              },
                            ),
                          );
                        },
                  child: Text(
                    AppTranslations.get(
                      selectedLanguage ?? 'English',
                      'continue',
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