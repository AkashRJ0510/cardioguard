import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogSymptomsScreen extends StatefulWidget {
  const LogSymptomsScreen({super.key});

  @override
  State<LogSymptomsScreen> createState() => _LogSymptomsScreenState();
}

class _LogSymptomsScreenState extends State<LogSymptomsScreen> {
  final List<String> symptoms = [
    'Shortness of breath',
    'Fatigue',
    'Weight gain',
    'Swelling (legs/ankles)',
    'Dizziness',
    'Chest pain',
    'Cough',
    'Irregular heartbeat',
  ];

  final Set<String> selectedSymptoms = {};

  bool _submitting = false;

  void _toggleSymptom(String symptom) {
    setState(() {
      if (selectedSymptoms.contains(symptom)) {
        selectedSymptoms.remove(symptom);
      } else {
        selectedSymptoms.add(symptom);
      }
    });
  }

  Future<void> _submitSymptoms() async {
    if (selectedSymptoms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least one symptom.")),
      );
      return;
    }

    setState(() => _submitting = true);

    final user = FirebaseAuth.instance.currentUser;
    final doc = FirebaseFirestore.instance
        .collection('symptom_logs')
        .doc(); // Auto ID

    try {
      await doc.set({
        'userId': user?.uid ?? '',
        'symptoms': selectedSymptoms.toList(),
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      setState(() => _submitting = false);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
      return;
    }

    setState(() => _submitting = false);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Symptoms logged successfully.")),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log Symptoms')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Select any symptoms you're experiencing:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: symptoms.map((symptom) {
                  final isSelected = selectedSymptoms.contains(symptom);
                  return Card(
                    color: isSelected ? Colors.red.shade50 : null,
                    child: CheckboxListTile(
                      value: isSelected,
                      onChanged: (_) => _toggleSymptom(symptom),
                      title: Text(symptom),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _submitting ? null : _submitSymptoms,
              icon: const Icon(Icons.check),
              label: Text(_submitting ? 'Saving...' : 'Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
