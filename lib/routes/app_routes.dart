import 'package:flutter/material.dart';
import '../screens/login/login_screen.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/login/forgot_password_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/main_tab_controller.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashScreen(),
  '/login': (context) => const LoginScreen(),
  '/signup': (context) => const SignupScreen(),
  '/dashboard': (context) => const DashboardScreen(),
  '/forgot-password': (context) => const ForgotPasswordScreen(),
  '/main-tabs': (context) => const MainTabController(),
};
