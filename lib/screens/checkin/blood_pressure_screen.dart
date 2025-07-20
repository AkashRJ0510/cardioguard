import 'package:flutter/material.dart';

class BloodPressureScreen extends StatefulWidget {
  const BloodPressureScreen({super.key});

  @override
  State<BloodPressureScreen> createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  final TextEditingController _systolicController = TextEditingController();
  final TextEditingController _diastolicController = TextEditingController();
  String? _statusMessage;

  void _saveReading() {
    final systolic = int.tryParse(_systolicController.text.trim());
    final diastolic = int.tryParse(_diastolicController.text.trim());

    if (systolic == null || diastolic == null) {
      setState(() {
        _statusMessage = 'Please enter valid numbers for both fields.';
      });
      return;
    }

    // You can add logic here to save readings to Firebase or local storage

    setState(() {
      _statusMessage =
          'Saved: $systolic / $diastolic mmHg (${_evaluateBP(systolic, diastolic)})';
    });

    _systolicController.clear();
    _diastolicController.clear();
  }

  String _evaluateBP(int systolic, int diastolic) {
    if (systolic < 120 && diastolic < 80) return "Normal";
    if (systolic < 130 && diastolic < 80) return "Elevated";
    if (systolic < 140 || diastolic < 90) return "Hypertension Stage 1";
    return "Hypertension Stage 2";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log Blood Pressure')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Enter your blood pressure reading',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _systolicController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Systolic (upper number)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _diastolicController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Diastolic (lower number)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveReading,
              child: const Text('Save Reading'),
            ),
            const SizedBox(height: 20),
            if (_statusMessage != null)
              Text(
                _statusMessage!,
                style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
