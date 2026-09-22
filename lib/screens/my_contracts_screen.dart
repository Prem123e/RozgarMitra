import 'package:flutter/material.dart';

import '../models/contract.dart';
import '../services/contract_store.dart';

class MyContractsScreen extends StatelessWidget {
  final String selectedLanguage;

  const MyContractsScreen({
    super.key,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final contracts = ContractStore.contracts;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Contracts',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: contracts.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: contracts.length,
                itemBuilder: (context, index) {
                  return _buildContractCard(
                    contracts[index],
                  );
                },
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description_outlined,
              size: 70,
            ),
            SizedBox(height: 20),
            Text(
              'No contracts yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Accepted job contracts will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContractCard(
    JobContract contract,
  ) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.description,
                  size: 38,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    contract.job.originalTitle,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildStatusBadge(
                  contract.status,
                ),
              ],
            ),
            const SizedBox(height: 18),
            _buildDetailRow(
              Icons.person,
              'Employer',
              contract.employerName,
            ),
            _buildDetailRow(
              Icons.location_on,
              'Location',
              contract.job.originalLocation,
            ),
            _buildDetailRow(
              Icons.currency_rupee,
              'Daily Wage',
              '₹${contract.dailyWage.toStringAsFixed(0)}',
            ),
            _buildDetailRow(
              Icons.calendar_today,
              'Contract Days',
              contract.totalDays.toString(),
            ),
            _buildDetailRow(
              Icons.access_time,
              'Daily Working Hours',
              contract.dailyWorkingHours,
            ),
            _buildDetailRow(
              Icons.event,
              'Start Date',
              contract.startDate,
            ),
            _buildDetailRow(
              Icons.event_available,
              'End Date',
              contract.endDate,
            ),
            const Divider(
              height: 28,
            ),
            _buildMoneyRow(
              'Total Contract Value',
              contract.totalContractValue,
            ),
            const SizedBox(height: 8),
            _buildMoneyRow(
              'Initial Escrow Requirement',
              contract.initialEscrowAmount,
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10),
                color: Colors.blue.shade50,
              ),
              child: const Text(
                'Payment and escrow are not connected to real money yet. '
                'This screen currently shows the calculated MVP values.',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
    String status,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.green.shade100,
      ),
      child: Text(
        status,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green.shade800,
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
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
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

  Widget _buildMoneyRow(
    String label,
    double amount,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          '₹${amount.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}