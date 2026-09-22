import '../models/application.dart';

class ApplicationStore {
  static final List<JobApplication> _applications = [];

  static List<JobApplication> get applications {
    return List.unmodifiable(_applications);
  }

  static void addApplication(
    JobApplication application,
  ) {
    _applications.add(application);
  }

  static bool hasAppliedToJob(
    String jobId,
  ) {
    return _applications.any(
      (application) => application.job.id == jobId,
    );
  }
}