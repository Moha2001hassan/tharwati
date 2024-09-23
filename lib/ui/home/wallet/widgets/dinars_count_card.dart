import 'package:flutter/material.dart';

class DinarCountCard extends StatelessWidget {
  const DinarCountCard({
    super.key,
    required int iraqDinarAmount,
  }) : _iraqDinarAmount = iraqDinarAmount;

  final int _iraqDinarAmount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "دينار عراقي",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Text(
              // selected amount
              _iraqDinarAmount.toString(),
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}