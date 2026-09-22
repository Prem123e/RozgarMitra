import '../models/job.dart';

class JobTranslationService {
  static JobTranslation getTranslationForWorker({
    required Job job,
    required String workerLanguage,
  }) {
    final existingTranslation =
        job.translations[workerLanguage];

    if (existingTranslation != null) {
      return existingTranslation;
    }

    if (workerLanguage == job.originalLanguage) {
      return JobTranslation(
        title: job.originalTitle,
        description: job.originalDescription,
        location: job.originalLocation,
        requiredSkill: job.originalRequiredSkill,
      );
    }

    return _translateJob(
      job: job,
      workerLanguage: workerLanguage,
    );
  }

  static JobTranslation _translateJob({
    required Job job,
    required String workerLanguage,
  }) {
    if (workerLanguage == 'తెలుగు') {
      return _translateToTelugu(job);
    }

    if (workerLanguage == 'हिन्दी') {
      return _translateToHindi(job);
    }

    if (workerLanguage == 'தமிழ்') {
      return _translateToTamil(job);
    }

    if (workerLanguage == 'ಕನ್ನಡ') {
      return _translateToKannada(job);
    }

    return JobTranslation(
      title: '[Translation unavailable]',
      description: '[Translation unavailable]',
      location: job.originalLocation,
      requiredSkill: '[Translation unavailable]',
    );
  }

  static JobTranslation _translateToTelugu(
    Job job,
  ) {
    return JobTranslation(
      title: _translateTeluguText(
        job.originalTitle,
      ),
      description: _translateTeluguText(
        job.originalDescription,
      ),
      location: _translateLocationToTelugu(
        job.originalLocation,
      ),
      requiredSkill: _translateTeluguText(
        job.originalRequiredSkill,
      ),
    );
  }

  static JobTranslation _translateToHindi(
    Job job,
  ) {
    return JobTranslation(
      title: _translateHindiText(
        job.originalTitle,
      ),
      description: _translateHindiText(
        job.originalDescription,
      ),
      location: _translateLocationToHindi(
        job.originalLocation,
      ),
      requiredSkill: _translateHindiText(
        job.originalRequiredSkill,
      ),
    );
  }

  static JobTranslation _translateToTamil(
    Job job,
  ) {
    return JobTranslation(
      title: _translateTamilText(
        job.originalTitle,
      ),
      description: _translateTamilText(
        job.originalDescription,
      ),
      location: job.originalLocation,
      requiredSkill: _translateTamilText(
        job.originalRequiredSkill,
      ),
    );
  }

  static JobTranslation _translateToKannada(
    Job job,
  ) {
    return JobTranslation(
      title: _translateKannadaText(
        job.originalTitle,
      ),
      description: _translateKannadaText(
        job.originalDescription,
      ),
      location: job.originalLocation,
      requiredSkill: _translateKannadaText(
        job.originalRequiredSkill,
      ),
    );
  }

  static String _translateTeluguText(
    String text,
  ) {
    final normalized = text.trim().toLowerCase();

    const translations = {
      'buffalo washing': 'గేదెలు కడగడం',
      'buffalo cleaning': 'గేదెల శుభ్రపరచడం',
      'buffalo washing and cleaning':
          'గేదెలు కడగడం మరియు శుభ్రపరచడం',
      'buffalo handling': 'గేదెల సంరక్షణ',
      'farm worker': 'వ్యవసాయ కార్మికుడు',
      'farm workers': 'వ్యవసాయ కార్మికులు',
      'agriculture work': 'వ్యవసాయ పని',
      'tractor driver': 'ట్రాక్టర్ డ్రైవర్',
      'tractor driver required':
          'ట్రాక్టర్ డ్రైవర్ కావాలి',
    };

    return translations[normalized] ?? text;
  }

  static String _translateHindiText(
    String text,
  ) {
    final normalized = text.trim().toLowerCase();

    const translations = {
      'buffalo washing': 'भैंस धोने का काम',
      'buffalo cleaning': 'भैंस की सफाई',
      'buffalo washing and cleaning':
          'भैंस धोने और साफ करने का काम',
      'buffalo handling': 'भैंस संभालने का काम',
      'farm worker': 'कृषि श्रमिक',
      'farm workers': 'कृषि श्रमिक',
      'agriculture work': 'कृषि कार्य',
      'tractor driver': 'ट्रैक्टर चालक',
      'tractor driver required':
          'ट्रैक्टर चालक चाहिए',
    };

    return translations[normalized] ?? text;
  }

  static String _translateTamilText(
    String text,
  ) {
    final normalized = text.trim().toLowerCase();

    const translations = {
      'buffalo washing': 'எருமை மாடுகளை கழுவும் வேலை',
      'buffalo cleaning': 'எருமை மாடுகளை சுத்தம் செய்யும் வேலை',
      'buffalo washing and cleaning':
          'எருமை மாடுகளை கழுவி சுத்தம் செய்யும் வேலை',
      'buffalo handling':
          'எருமை மாடுகளை கையாளும் வேலை',
      'farm worker': 'விவசாயத் தொழிலாளர்',
      'farm workers': 'விவசாயத் தொழிலாளர்கள்',
      'agriculture work': 'விவசாய வேலை',
      'tractor driver': 'டிராக்டர் ஓட்டுநர்',
      'tractor driver required':
          'டிராக்டர் ஓட்டுநர் தேவை',
    };

    return translations[normalized] ?? text;
  }

  static String _translateKannadaText(
    String text,
  ) {
    final normalized = text.trim().toLowerCase();

    const translations = {
      'buffalo washing': 'ಎಮ್ಮೆಗಳನ್ನು ತೊಳೆಯುವ ಕೆಲಸ',
      'buffalo cleaning': 'ಎಮ್ಮೆಗಳನ್ನು ಸ್ವಚ್ಛಗೊಳಿಸುವ ಕೆಲಸ',
      'buffalo washing and cleaning':
          'ಎಮ್ಮೆಗಳನ್ನು ತೊಳೆಯುವ ಮತ್ತು ಸ್ವಚ್ಛಗೊಳಿಸುವ ಕೆಲಸ',
      'buffalo handling':
          'ಎಮ್ಮೆಗಳನ್ನು ನೋಡಿಕೊಳ್ಳುವ ಕೆಲಸ',
      'farm worker': 'ಕೃಷಿ ಕಾರ್ಮಿಕ',
      'farm workers': 'ಕೃಷಿ ಕಾರ್ಮಿಕರು',
      'agriculture work': 'ಕೃಷಿ ಕೆಲಸ',
      'tractor driver': 'ಟ್ರ್ಯಾಕ್ಟರ್ ಚಾಲಕ',
      'tractor driver required':
          'ಟ್ರ್ಯಾಕ್ಟರ್ ಚಾಲಕ ಬೇಕಾಗಿದೆ',
    };

    return translations[normalized] ?? text;
  }

  static String _translateLocationToTelugu(
    String location,
  ) {
    final normalized = location.trim().toLowerCase();

    const locations = {
      'warangal': 'వరంగల్',
      'hyderabad': 'హైదరాబాద్',
      'karimnagar': 'కరీంనగర్',
      'hanamkonda': 'హనుమకొండ',
    };

    return locations[normalized] ?? location;
  }

  static String _translateLocationToHindi(
    String location,
  ) {
    final normalized = location.trim().toLowerCase();

    const locations = {
      'warangal': 'वारंगल',
      'hyderabad': 'हैदराबाद',
      'karimnagar': 'करीमनगर',
      'hanamkonda': 'हनमकोंडा',
    };

    return locations[normalized] ?? location;
  }
}