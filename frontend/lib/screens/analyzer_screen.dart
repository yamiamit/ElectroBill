import 'package:flutter/material.dart';

class AnalyzeScreen extends StatefulWidget {
  @override
  _AnalyzeScreenState createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  final TextEditingController consumerIdController = TextEditingController();
  final TextEditingController billAmountController = TextEditingController();
  final TextEditingController billDurationController = TextEditingController();

  String? selectedState;
  String? selectedPerUnit;
  List<Map<String, TextEditingController>> consumptionList = [];

  final List<String> states = ['State A', 'State B', 'State C'];
  final List<String> perUnitOptions = ['INR/kWh', 'USD/kWh'];

  @override
  void initState() {
    super.initState();
    addConsumptionRow();
  }

  void addConsumptionRow() {
    setState(() {
      consumptionList.add({
        'equipment': TextEditingController(),
        'power': TextEditingController(),
        'avgUsage': TextEditingController(),
      });
    });
  }

  void removeConsumptionRow(int index) {
    setState(() {
      consumptionList.removeAt(index);
    });
  }

  void handleSubmit() {
    // Process submission logic here
    print('Submit pressed');
  }

  @override
  Widget build(BuildContext context) {
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
            Text('Bill Duration (in months)'),
            TextField(
              controller: billDurationController,
              keyboardType: TextInputType.number,
            ),

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
                    onChanged: (value) =>
                        setState(() => selectedPerUnit = value),
                  ),
                ),
              ],
            ),

            Divider(height: 30),
            Text('Consumption', style: TextStyle(fontSize: 16)),

            Column(
              children: List.generate(consumptionList.length, (index) {
                final item = consumptionList[index];
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: item['equipment'],
                        decoration: InputDecoration(labelText: 'Equipment'),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: item['power'],
                        decoration: InputDecoration(labelText: 'Power (W)'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: item['avgUsage'],
                        decoration:
                        InputDecoration(labelText: 'Avg. Usage (hrs/day)'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => removeConsumptionRow(index),
                    ),
                  ],
                );
              }),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: Text('Add Row'),
                onPressed: addConsumptionRow,
              ),
            ),

            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: handleSubmit,
                child: Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
