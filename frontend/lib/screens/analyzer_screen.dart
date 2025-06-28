import 'package:flutter/material.dart';
import 'package:frontend/screens/consumer_details.dart';
import 'package:intl/intl.dart';

class AnalyzeScreen extends StatefulWidget {
  @override
  _AnalyzeScreenState createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  final TextEditingController consumerIdController = TextEditingController();
  final TextEditingController billAmountController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  String? selectedState;
  String? selectedPerUnit;

  final List<String> states = ['State A', 'State B', 'State C'];
  final List<String> perUnitOptions = ['INR/kWh', 'USD/kWh'];

  int getCalculatedMonths() {
    if (startDate == null || endDate == null) return 0;
    return (endDate!.year - startDate!.year) * 12 + endDate!.month - startDate!.month;
  }

  Future<void> pickDate(BuildContext context, bool isStart) async {
    final initialDate = isStart ? (startDate ?? DateTime.now()) : (endDate ?? DateTime.now());
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (newDate != null) {
      setState(() {
        if (isStart) {
          startDate = newDate;
          if (endDate != null && endDate!.isBefore(startDate!)) endDate = null;
        } else {
          endDate = newDate;
        }
      });
    }
  }

  void handleProceed() {
    final consumerId = consumerIdController.text.trim();
    final billAmount = double.tryParse(billAmountController.text.trim()) ?? 0;
    final duration = getCalculatedMonths();

    if (consumerId.isEmpty || billAmount <= 0 || duration <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete all fields correctly')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConsumerDetailsScreen(
          consumerId: consumerId,
          billAmount: billAmount,
          billDuration: duration,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(title: Text('Bill Analyzer')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Consumer ID'),
            TextField(controller: consumerIdController),

            SizedBox(height: 10),
            Text('Bill Amount'),
            TextField(
              controller: billAmountController,
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 10),
            Text('Start Date'),
            ListTile(
              title: Text(startDate != null
                  ? dateFormat.format(startDate!)
                  : 'Select Start Date'),
              trailing: Icon(Icons.calendar_today),
              onTap: () => pickDate(context, true),
            ),

            Text('End Date'),
            ListTile(
              title: Text(endDate != null
                  ? dateFormat.format(endDate!)
                  : 'Select End Date'),
              trailing: Icon(Icons.calendar_today),
              onTap: () => pickDate(context, false),
            ),

            SizedBox(height: 10),
            Text('Duration (in months): ${getCalculatedMonths()}'),

            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedState,
                    decoration: InputDecoration(labelText: 'State'),
                    items: states
                        .map((state) =>
                        DropdownMenuItem(value: state, child: Text(state)))
                        .toList(),
                    onChanged: (value) => setState(() => selectedState = value),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedPerUnit,
                    decoration: InputDecoration(labelText: 'Per Unit'),
                    items: perUnitOptions
                        .map((unit) =>
                        DropdownMenuItem(value: unit, child: Text(unit)))
                        .toList(),
                    onChanged: (value) => setState(() => selectedPerUnit = value),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: handleProceed,
                child: Text('Proceed'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
