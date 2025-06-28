import 'package:flutter/material.dart';
import 'dart:math';

import 'package:frontend/screens/home_screen.dart';

class GeneticAlgorithmScreen extends StatelessWidget {
  final List<Map<String, dynamic>> inputData;
  final double actualBillAmount;
  final int duration;

  GeneticAlgorithmScreen({
    required this.inputData,
    required this.actualBillAmount,
    required this.duration,
  });

  double _calculateEstimatedBill() {
    double totalKWh = 0.0;
    double tariffRate = 7.5; // ₹ per kWh

    for (var item in inputData) {
      double powerKW = item['power'] / 1000.0;
      double dailyUsage = item['avgUsage'];
      totalKWh += powerKW * dailyUsage * duration;
    }

    double factor = 0.95 + Random().nextDouble() * 0.1;
    double adjustedKWh = totalKWh * factor;

    return adjustedKWh * tariffRate;
  }

  Map<String, dynamic> _getHighestPowerDevice() {
    return inputData.cast<Map<String, dynamic>>().reduce(
          (curr, next) => (curr['power'] as num) > (next['power'] as num) ? curr : next,
    );
  }

  @override
  Widget build(BuildContext context) {
    double estimatedBill = _calculateEstimatedBill();
    double deviation = (estimatedBill - actualBillAmount).abs();
    Map<String, dynamic> highestDevice = _getHighestPowerDevice();

    return Scaffold(
      appBar: AppBar(title: Text('Bill Estimation Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Actual Bill: ₹${actualBillAmount.toStringAsFixed(2)}'),
            SizedBox(height: 10),
            Text('Estimated Bill: ₹${estimatedBill.toStringAsFixed(2)}'),
            SizedBox(height: 10),
            Text('Deviation: ₹${deviation.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            const Text(
              '⚠️ Suspiciously Consuming Device:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            Text('Name: ${highestDevice['equipment']}'),
            Text('Power: ${highestDevice['power']} W'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(name: 'Amit'),
                ),
              ),
              child: Text('Home Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
