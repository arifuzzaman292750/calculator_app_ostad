import 'package:batch_9_apps/features/bmi_app/ui/screens/bmi_screen.dart';
import 'package:batch_9_apps/features/expense-tracker/ui/screens/expense_tracker_screen.dart';
import 'package:batch_9_apps/features/rest_api_concept/ui/screens/rest_api_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BmiScreen(),
    );
  }
}