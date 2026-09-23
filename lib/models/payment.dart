import 'earning.dart';

class WorkerPayment {
  final String id;
  final WorkerEarning earning;
  final String workerName;
  final double amount;
  final DateTime createdAt;

  String status;
  DateTime? paidAt;

  WorkerPayment({
    required this.id,
    required this.earning,
    required this.workerName,
    required this.amount,
    required this.createdAt,
    required this.status,
    this.paidAt,
  });

  bool get isPending {
    return status == 'Pending Payment';
  }

  bool get isPaid {
    return status == 'Paid';
  }

  void markAsPaid() {
    status = 'Paid';
    paidAt = DateTime.now();
  }
}