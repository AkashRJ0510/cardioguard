import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/rounded_card.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Check-In'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Let's check how you're doing today",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Heart Rate
            RoundedCard(
              icon: FontAwesomeIcons.heartPulse,
              title: "Measure Heart Rate",
              subtitle: "Use camera to detect BPM",
              onTap: () {
                Navigator.pushNamed(context, '/checkin/heart-rate');
              },
            ),

            const SizedBox(height: 15),

            // Log Symptoms
            RoundedCard(
              icon: FontAwesomeIcons.notesMedical,
              title: "Log Symptoms",
              subtitle: "Report how you’re feeling",
              onTap: () {
                Navigator.pushNamed(context, '/log-symptoms');
              },
            ),

            const SizedBox(height: 15),

            // Add Blood Pressure
            RoundedCard(
              icon: FontAwesomeIcons.stethoscope,
              title: "Add Blood Pressure",
              subtitle: "Manually input BP values",
              onTap: () {
                Navigator.pushNamed(context, '/blood-pressure');
              },
            ),
          ],
        ),
      ),
    );
  }
}
