import '../models/job.dart';

class JobStore {
  static final List<Job> _jobs = [];

  static List<Job> get jobs {
    return List.unmodifiable(_jobs);
  }

  static void addJob(
    Job job,
  ) {
    _jobs.add(job);
  }

  static Job? getJobById(
    String jobId,
  ) {
    for (final job in _jobs) {
      if (job.id == jobId) {
        return job;
      }
    }

    return null;
  }

  static bool containsJob(
    String jobId,
  ) {
    return _jobs.any(
      (job) => job.id == jobId,
    );
  }
}