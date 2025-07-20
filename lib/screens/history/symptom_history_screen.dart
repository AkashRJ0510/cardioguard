import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SymptomHistoryScreen extends StatefulWidget {
  const SymptomHistoryScreen({super.key});

  @override
  State<SymptomHistoryScreen> createState() => _SymptomHistoryScreenState();
}

class _SymptomHistoryScreenState extends State<SymptomHistoryScreen> {
  List<Map<String, dynamic>> logs = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchLogs();
  }

  Future<void> fetchLogs() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      debugPrint("Current Logged-in UID: $userId");

      if (userId == null) {
        setState(() {
          loading = false;
        });
        return;
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('symptom_logs')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      final fetchedLogs = snapshot.docs.map((doc) {
        debugPrint("Fetched log: ${doc.data()}");
        return doc.data();
      }).toList();

      setState(() {
        logs = List<Map<String, dynamic>>.from(fetchedLogs);
        loading = false;
      });
    } catch (e, stack) {
      debugPrint('Error fetching logs: $e\n$stack');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Symptom History"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : logs.isEmpty
          ? const Center(child: Text("No symptom logs found."))
          : ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final entry = logs[index];
                final symptoms = List<String>.from(entry['symptoms'] ?? []);
                final timestamp = (entry['timestamp'] as Timestamp?)?.toDate();

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text("Symptoms: ${symptoms.join(', ')}"),
                    subtitle: Text(
                      timestamp != null
                          ? "Logged on: ${timestamp.toLocal().toString().substring(0, 16)}"
                          : "No timestamp",
                    ),
                  ),
                );
              },
            ),
    );
  }
}
