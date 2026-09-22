import '../models/contract.dart';

class ContractStore {
  static final List<JobContract> _contracts = [];

  static List<JobContract> get contracts {
    return List.unmodifiable(
      _contracts,
    );
  }

  static void addContract(
    JobContract contract,
  ) {
    _contracts.add(contract);
  }

  static JobContract? getContractById(
    String contractId,
  ) {
    for (final contract in _contracts) {
      if (contract.id == contractId) {
        return contract;
      }
    }

    return null;
  }

  static bool hasContractForApplication({
    required String jobId,
    required String workerName,
  }) {
    return _contracts.any(
      (contract) =>
          contract.job.id == jobId &&
          contract.workerName == workerName,
    );
  }
}