import 'package:flutter/material.dart';
import '../screens/login/login_screen.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const LoginScreen(),
  '/signup': (context) => const SignupScreen(),
  '/dashboard': (context) => const DashboardScreen(),
};
