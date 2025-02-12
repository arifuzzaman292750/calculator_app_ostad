import 'package:batch_9_apps/features/water-tracker/ui/widgets/add_water_button.dart';
import 'package:flutter/material.dart';

class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  @override
  Widget build(BuildContext context) {

    double progress = (_currentWaterIntake / _goal).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Water Tracker'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue,
                      spreadRadius: 2,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    spacing: 8,
                    children: [
                      Text(
                        "Today's Intake",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${_currentWaterIntake}ml',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade400,
                      color: Colors.blue,
                      strokeWidth: 12,
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Wrap(
                children: [
                  AddWaterButton(
                    amount: 100,
                    icon: Icons.local_drink,
                    onPressed: () => _addWater(100),
                  ),
                  AddWaterButton(
                    amount: 200,
                    onPressed: () => _addWater(200),
                  ),
                  AddWaterButton(
                    amount: 500,
                    icon: Icons.local_cafe,
                    onPressed: () => _addWater(500),
                  ),
                ],
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _resetWater,
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _currentWaterIntake = 0;
  final _goal = 2000;

  void _addWater(int amount) {
    if (_currentWaterIntake < _goal) {
      _currentWaterIntake = (_currentWaterIntake + amount).clamp(0, _goal);
      setState(() {});
    }
  }

  void _resetWater() {
    _currentWaterIntake = 0;
    setState(() {});
  }
}
