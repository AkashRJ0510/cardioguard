import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CardioGuard Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome 👋', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            const Text('🩺 Risk Score: 72%', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 15),
            const Text('📊 Vitals Summary:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text('• Heart Rate: 82 bpm'),
            const Text('• Blood Pressure: 118/76 mmHg'),
            const Text('• Weight: 72 kg'),
          ],
        ),
      ),
    );
  }
}
