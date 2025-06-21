import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Past Check-Ins',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildHistoryCard(
            'Jun 20, 2025',
            'Feeling Okay',
            'No symptoms today.',
          ),
          _buildHistoryCard(
            'Jun 19, 2025',
            'Mild Fatigue',
            'Slight tiredness, normal vitals.',
          ),
          _buildHistoryCard(
            'Jun 18, 2025',
            'Shortness of Breath',
            'Mild difficulty breathing after climbing stairs.',
          ),
          // You can add more dummy entries or fetch from Firestore later
        ],
      ),
    );
  }

  Widget _buildHistoryCard(String date, String status, String notes) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text(status),
        subtitle: Text(notes),
        trailing: Text(date, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}
