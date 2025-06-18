import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class CardioGuardApp extends StatelessWidget {
  const CardioGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CardioGuardApp',
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
