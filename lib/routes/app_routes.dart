import 'package:flutter/material.dart';
import '../screens/login/login_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const LoginScreen(),
};
