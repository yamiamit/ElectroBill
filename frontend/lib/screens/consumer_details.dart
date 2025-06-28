import 'package:flutter/material.dart';
import 'package:frontend/screens/geneticAlgorithm.dart';

class ConsumerDetailsScreen extends StatefulWidget {
  final String consumerId;
  final double billAmount;
  final int billDuration;

  ConsumerDetailsScreen({
    required this.consumerId,
    required this.billAmount,
    required this.billDuration,
  });

  @override
  _ConsumerDetailsScreenState createState() => _ConsumerDetailsScreenState();
}

class _ConsumerDetailsScreenState extends State<ConsumerDetailsScreen> {
  List<Map<String, TextEditingController>> consumptionList = [];

  @override
  void initState() {
    super.initState();
    _addConsumptionRow();
  }

  void _addConsumptionRow() {
    setState(() {
      consumptionList.add({
        'equipment': TextEditingController(),
        'power': TextEditingController(),
        'avgUsage': TextEditingController(),
      });
    });
  }

  void _removeConsumptionRow(int index) {
    setState(() {
      consumptionList.removeAt(index);
    });
  }

  void _handleSubmit() async {
    List<Map<String, dynamic>> inputData = consumptionList.map((item) {
      return {
        'equipment': item['equipment']!.text,
        'power': double.tryParse(item['power']!.text) ?? 0.0,
        'avgUsage': double.tryParse(item['avgUsage']!.text) ?? 0.0,
      };
    }).toList();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );

    await Future.delayed(Duration(seconds: 2)); // simulate processing

    Navigator.of(context).pop(); // remove loading

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GeneticAlgorithmScreen(
          inputData: inputData,
          actualBillAmount: widget.billAmount,
          duration: widget.billDuration,
        ),
      ),
    );
  }

  Widget _buildConsumptionRow(int index) {
    final item = consumptionList[index];
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: item['equipment'],
              decoration: InputDecoration(
                labelText: 'Equipment Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: item['power'],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Power (Watts)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: item['avgUsage'],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Average Usage (hrs/day)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeConsumptionRow(index),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Equipment Usage Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: consumptionList.length,
                itemBuilder: (_, index) => _buildConsumptionRow(index),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Add Equipment'),
                  onPressed: _addConsumptionRow,
                ),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  child: Text('Submit'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
