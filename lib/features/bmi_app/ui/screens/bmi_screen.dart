import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController _feetTEController = TextEditingController();
  final TextEditingController _inchTEController = TextEditingController();
  final TextEditingController _weightTEController = TextEditingController();

  late double bmiResult = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 12),
              TextFormField(
                controller: _feetTEController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (feet)',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _inchTEController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (inch)',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _weightTEController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _bmiCalculation();
                  _clearTextFormFields();
                },
                child: Text('Calculate'),
              ),
              SizedBox(height: 16),
              Text(bmiResult.toString()),
              SizedBox(height: 10),
              SizedBox(
                height: 250,
                width: 300,
                child: SfRadialGauge(
                  title: GaugeTitle(
                    text: 'BMI Calculation',
                    textStyle: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 16,
                      maximum: 41,
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startValue: 16,
                          endValue: 18,
                          color: Colors.white,
                          startWidth: 10,
                          endWidth: 10,
                        ),
                        GaugeRange(
                          startValue: 18,
                          endValue: 25,
                          color: Colors.green,
                          startWidth: 10,
                          endWidth: 10,
                        ),
                        GaugeRange(
                          startValue: 25,
                          endValue: 39,
                          color: Colors.yellow,
                          startWidth: 10,
                          endWidth: 10,
                        ),
                        GaugeRange(
                          startValue: 39,
                          endValue: 41,
                          color: Colors.red,
                          startWidth: 10,
                          endWidth: 10,
                        ),
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(value: bmiResult),
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Container(
                              child: Text(
                                bmiResult.toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            angle: 90,
                            positionFactor: 0.5),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _bmiCalculation() {
    double feet = double.tryParse(_feetTEController.text) ?? 0;
    double inch = double.tryParse(_feetTEController.text) ?? 0;
    double weight = double.tryParse(_feetTEController.text) ?? 0;

    double heightInMeters =
        (((feet * 12) + inch) * 0.0254); // Convert feet to meters

    bmiResult = weight / (heightInMeters * heightInMeters);
    setState(() {});
  }

  void _clearTextFormFields() {
    _feetTEController.clear();
    _inchTEController.clear();
    _weightTEController.clear();
  }

  @override
  void dispose() {
    _feetTEController.dispose();
    _inchTEController.dispose();
    _weightTEController.dispose();
    super.dispose();
  }
}
