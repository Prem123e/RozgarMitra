class Job {
  final String id;
  final String title;
  final String description;
  final String location;
  final double dailyWage;
  final int numberOfWorkers;
  final String workDate;
  final String requiredSkill;
  final String employerName;
  final String status;
  final DateTime createdAt;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.dailyWage,
    required this.numberOfWorkers,
    required this.workDate,
    required this.requiredSkill,
    required this.employerName,
    required this.status,
    required this.createdAt,
  });
}