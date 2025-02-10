import 'package:batch_9_apps/ui/widgets/build_elevated_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _outPut = '0';
  String _inPut = '';
  String _operation = '';
  double num1 = 0;
  double num2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Calculator',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                _outPut,
                style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Row(
            children: [
              BuildElevatedButton(
                text: '7',
                onPressed: () => _buttonPressed('7'),
              ),
              BuildElevatedButton(
                text: '8',
                onPressed: () => _buttonPressed('8'),
              ),
              BuildElevatedButton(
                text: '9',
                onPressed: () => _buttonPressed('9'),
              ),
              BuildElevatedButton(
                text: '/',
                onPressed: () => _buttonPressed('/'),
                color: Colors.orange,
              ),
            ],
          ),
          Row(
            children: [
              BuildElevatedButton(
                text: '4',
                onPressed: () => _buttonPressed('4'),
              ),
              BuildElevatedButton(
                text: '5',
                onPressed: () => _buttonPressed('5'),
              ),
              BuildElevatedButton(
                text: '6',
                onPressed: () => _buttonPressed('6'),
              ),
              BuildElevatedButton(
                text: 'x',
                onPressed: () => _buttonPressed('x'),
                color: Colors.orange,
              ),
            ],
          ),
          Row(
            children: [
              BuildElevatedButton(
                text: '1',
                onPressed: () => _buttonPressed('1'),
              ),
              BuildElevatedButton(
                text: '2',
                onPressed: () => _buttonPressed('2'),
              ),
              BuildElevatedButton(
                text: '3',
                onPressed: () => _buttonPressed('3'),
              ),
              BuildElevatedButton(
                text: '-',
                onPressed: () => _buttonPressed('-'),
                color: Colors.orange,
              ),
            ],
          ),
          Row(
            children: [
              BuildElevatedButton(
                text: 'C',
                onPressed: () => _buttonPressed('C'),
                color: Colors.red,
              ),
              BuildElevatedButton(
                text: '0',
                onPressed: () => _buttonPressed('0'),
              ),
              BuildElevatedButton(
                text: '=',
                onPressed: () => _buttonPressed('='),
                color: Colors.green,
              ),
              BuildElevatedButton(
                text: '+',
                onPressed: () => _buttonPressed('+'),
                color: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _outPut = '0';
        _inPut = '';
        _operation = '';
        num1 = 0;
        num2 = 0;
      } else if (value == '=') {
        num2 = double.parse(_inPut);
        if (_operation == '+') {
          _outPut = (num1 + num2).toString();
        } else if (_operation == '-') {
          _outPut = (num1 - num2).toString();
        } else if (_operation == 'x') {
          _outPut = (num1 * num2).toString();
        } else if (_operation == '/') {
          _outPut = (num2 != 0) ? (num1 / num2).toString() : 'Error';
        }
        _inPut = _outPut;
      } else if (['+', '-', 'x', '/'].contains(value)) {
        num1 = double.parse(_inPut);
        _operation = value;
        _inPut = '';
      } else {
        _inPut += value;
        _outPut = _inPut;
      }
    });
  }
}
