class Job {
  final String id;

  final String originalLanguage;
  final String originalTitle;
  final String originalDescription;
  final String originalLocation;
  final String originalRequiredSkill;

  final Map<String, JobTranslation> translations;

  final double dailyWage;
  final int numberOfWorkers;
  final String workDate;
  final String contractEndDate;
  final String employerName;
  final String status;
  final DateTime createdAt;

  Job({
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.originalDescription,
    required this.originalLocation,
    required this.originalRequiredSkill,
    required this.translations,
    required this.dailyWage,
    required this.numberOfWorkers,
    required this.workDate,
    required this.contractEndDate,
    required this.employerName,
    required this.status,
    required this.createdAt,
  });

  JobTranslation getTranslation(
    String language,
  ) {
    return translations[language] ??
        JobTranslation(
          title: originalTitle,
          description: originalDescription,
          location: originalLocation,
          requiredSkill: originalRequiredSkill,
        );
  }
}

class JobTranslation {
  final String title;
  final String description;
  final String location;
  final String requiredSkill;

  JobTranslation({
    required this.title,
    required this.description,
    required this.location,
    required this.requiredSkill,
  });
}