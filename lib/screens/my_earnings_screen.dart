import 'package:flutter/material.dart';

import '../models/earning.dart';
import '../services/earning_store.dart';

class MyEarningsScreen extends StatelessWidget {
  final String selectedLanguage;
  final String workerName;

  const MyEarningsScreen({
    super.key,
    required this.selectedLanguage,
    required this.workerName,
  });

  @override
  Widget build(BuildContext context) {
    final earnings =
        EarningStore.getEarningsForWorker(
      workerName,
    );

    final totalEarnings =
        EarningStore.getTotalEarningsForWorker(
      workerName,
    );

    final verifiedDays =
        EarningStore
            .getVerifiedEarningDaysForWorker(
      workerName,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Earnings',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: earnings.isEmpty
            ? _buildEmptyState()
            : ListView(
                padding:
                    const EdgeInsets.all(16),
                children: [
                  _buildSummaryCard(
                    totalEarnings,
                    verifiedDays,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Earning History',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ...earnings.map(
                    _buildEarningCard,
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
              Icons.account_balance_wallet_outlined,
              size: 72,
            ),
            SizedBox(height: 20),
            Text(
              'No Earnings Yet',
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
              'Verified work earnings will appear here.',
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
    double totalEarnings,
    int verifiedDays,
  ) {
    return Card(
      elevation: 3,
      child: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Total Earned',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '₹${totalEarnings.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 34,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child:
                      _buildSummaryItem(
                    Icons.verified,
                    'Verified Days',
                    verifiedDays
                        .toString(),
                  ),
                ),
                Expanded(
                  child:
                      _buildSummaryItem(
                    Icons.currency_rupee,
                    'Recorded Earnings',
                    '₹${totalEarnings.toStringAsFixed(0)}',
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
    String value,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style:
              const TextStyle(
            fontSize: 20,
            fontWeight:
                FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          label,
          textAlign:
              TextAlign.center,
          style:
              const TextStyle(
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildEarningCard(
    WorkerEarning earning,
  ) {
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
                  Icons.verified,
                  size: 32,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    earning
                        .attendance
                        .contract
                        .job
                        .originalTitle,
                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            _buildDetailRow(
              Icons.calendar_today,
              'Date',
              earning.date,
            ),
            _buildDetailRow(
              Icons.currency_rupee,
              'Daily Wage',
              '₹${earning.dailyWage.toStringAsFixed(0)}',
            ),
            _buildDetailRow(
              Icons.payments,
              'Earned',
              '₹${earning.earnedAmount.toStringAsFixed(0)}',
            ),
            _buildDetailRow(
              Icons.verified,
              'Status',
              earning.status,
            ),
          ],
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
}