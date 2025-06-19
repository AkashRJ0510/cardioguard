import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // ✅ This should already be generated
import 'app.dart'; // ✅ Your main app widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for async code before runApp
  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform, // Important for web & mobile
  );
  runApp(const CardioGuardApp());
}
