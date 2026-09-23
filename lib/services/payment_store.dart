import '../models/payment.dart';

class PaymentStore {
  static final List<WorkerPayment> _payments = [];

  static List<WorkerPayment> get payments {
    return List.unmodifiable(
      _payments,
    );
  }

  static void addPayment(
    WorkerPayment payment,
  ) {
    _payments.add(payment);
  }

  static WorkerPayment? getPaymentById(
    String paymentId,
  ) {
    for (final payment in _payments) {
      if (payment.id == paymentId) {
        return payment;
      }
    }

    return null;
  }

  static WorkerPayment? getPaymentForEarning(
    String earningId,
  ) {
    for (final payment in _payments) {
      if (payment.earning.id == earningId) {
        return payment;
      }
    }

    return null;
  }

  static bool hasPaymentForEarning(
    String earningId,
  ) {
    return _payments.any(
      (payment) =>
          payment.earning.id == earningId,
    );
  }

  static List<WorkerPayment>
      getPaymentsForWorker(
    String workerName,
  ) {
    return _payments
        .where(
          (payment) =>
              payment.workerName ==
              workerName,
        )
        .toList();
  }

  static double getTotalPendingAmountForWorker(
    String workerName,
  ) {
    return getPaymentsForWorker(
      workerName,
    )
        .where(
          (payment) =>
              payment.status ==
              'Pending Payment',
        )
        .fold(
          0,
          (
            total,
            payment,
          ) =>
              total + payment.amount,
        );
  }

  static double getTotalPaidAmountForWorker(
    String workerName,
  ) {
    return getPaymentsForWorker(
      workerName,
    )
        .where(
          (payment) =>
              payment.status ==
              'Paid',
        )
        .fold(
          0,
          (
            total,
            payment,
          ) =>
              total + payment.amount,
        );
  }
}