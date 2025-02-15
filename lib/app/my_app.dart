import 'package:batch_9_apps/features/calculator/ui/screens/calculator_screen.dart';
import 'package:batch_9_apps/features/expense-tracker/ui/screens/expense_tracker_screen.dart';
import 'package:batch_9_apps/features/water-tracker/ui/screens/water_tracker_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpenseTrackerScreen(),
    );
  }
}