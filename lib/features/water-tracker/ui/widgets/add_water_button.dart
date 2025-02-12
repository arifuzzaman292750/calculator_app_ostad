import 'package:flutter/material.dart';

class AddWaterButton extends StatelessWidget {
  AddWaterButton({
    super.key,
    required this.amount,
    this.icon,
    required this.onPressed,
  });

  final int amount;
  IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          label: Text(
            '+ $amount ml',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: Icon(icon ?? Icons.water_drop, color: Colors.blue, size: 20),
        ),
      ),
    );
  }
}
