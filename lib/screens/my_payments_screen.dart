import 'package:flutter/material.dart';

import '../models/payment.dart';
import '../services/payment_store.dart';

class MyPaymentsScreen extends StatelessWidget {
  final String selectedLanguage;
  final String workerName;

  const MyPaymentsScreen({
    super.key,
    required this.selectedLanguage,
    required this.workerName,
  });

  @override
  Widget build(BuildContext context) {
    final payments =
        PaymentStore.getPaymentsForWorker(
      workerName,
    );

    final pendingAmount =
        PaymentStore.getTotalPendingAmountForWorker(
      workerName,
    );

    final paidAmount =
        PaymentStore.getTotalPaidAmountForWorker(
      workerName,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Payments',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: payments.isEmpty
            ? _buildEmptyState()
            : ListView(
                padding:
                    const EdgeInsets.all(16),
                children: [
                  _buildSummaryCard(
                    pendingAmount,
                    paidAmount,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Payment History',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ...payments.map(
                    _buildPaymentCard,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding:
            EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.payments_outlined,
              size: 72,
            ),
            SizedBox(height: 20),
            Text(
              'No Payments Yet',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your payment records will appear here after verified work becomes eligible for payment.',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    double pendingAmount,
    double paidAmount,
  ) {
    return Card(
      elevation: 3,
      child: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Payment Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Expanded(
                  child:
                      _buildSummaryItem(
                    Icons.pending_actions,
                    'Pending',
                    '₹${pendingAmount.toStringAsFixed(0)}',
                  ),
                ),
                Expanded(
                  child:
                      _buildSummaryItem(
                    Icons.check_circle,
                    'Paid',
                    '₹${paidAmount.toStringAsFixed(0)}',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    IconData icon,
    String label,
    String amount,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          amount,
          style:
              const TextStyle(
            fontSize: 22,
            fontWeight:
                FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          label,
          style:
              const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentCard(
    WorkerPayment payment,
  ) {
    final job =
        payment.earning.attendance.contract.job;

    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.payments,
                  size: 34,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    job.originalTitle,
                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
                _buildStatusBadge(
                  payment,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            _buildDetailRow(
              Icons.currency_rupee,
              'Amount',
              '₹${payment.amount.toStringAsFixed(0)}',
            ),
            _buildDetailRow(
              Icons.calendar_today,
              'Work Date',
              payment.earning.date,
            ),
            _buildDetailRow(
              Icons.location_on,
              'Location',
              job.originalLocation,
            ),
            _buildDetailRow(
              Icons.receipt_long,
              'Payment ID',
              payment.id,
            ),
            _buildDetailRow(
              Icons.access_time,
              'Created',
              _formatDateTime(
                payment.createdAt,
              ),
            ),
            if (payment.paidAt != null)
              _buildDetailRow(
                Icons.check_circle,
                'Paid At',
                _formatDateTime(
                  payment.paidAt!,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
    WorkerPayment payment,
  ) {
    final isPaid = payment.isPaid;

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(20),
        color: isPaid
            ? Colors.green.shade100
            : Colors.orange.shade100,
      ),
      child: Text(
        payment.status,
        style: TextStyle(
          fontWeight:
              FontWeight.bold,
          fontSize: 12,
          color: isPaid
              ? Colors.green.shade800
              : Colors.orange.shade800,
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 19,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text:
                        '$label: ',
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: value,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(
    DateTime value,
  ) {
    final day =
        value.day.toString().padLeft(
              2,
              '0',
            );

    final month =
        value.month.toString().padLeft(
              2,
              '0',
            );

    final year =
        value.year.toString();

    final hour =
        value.hour.toString().padLeft(
              2,
              '0',
            );

    final minute =
        value.minute.toString().padLeft(
              2,
              '0',
            );

    return '$day-$month-$year $hour:$minute';
  }
}