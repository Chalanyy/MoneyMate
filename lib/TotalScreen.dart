import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalScreen extends StatefulWidget {
  final List<Map<String, dynamic>> expenses;

  TotalScreen({Key? key, required this.expenses, required double totalAmount}) : super(key: key);

  @override
  _TotalScreenState createState() => _TotalScreenState();
}

class _TotalScreenState extends State<TotalScreen> {
  Map<String, double> targetExpenses = {
    'January 2025': 30000.0,
    'February 2025': 35000.0,
    'March 2025': 40000.0,
  };

  String _getMonthYear(DateTime date) {
    final DateFormat formatter = DateFormat('MMMM yyyy');
    return formatter.format(date);
  }

  Map<String, double> _calculateMonthlyExpenses() {
    Map<String, double> monthlyExpenses = {};
    for (var expense in widget.expenses) {
      DateTime expenseDate = expense['date'];
      String monthYear = _getMonthYear(expenseDate);
      monthlyExpenses[monthYear] =
          (monthlyExpenses[monthYear] ?? 0) + expense['amount'];
    }
    return monthlyExpenses;
  }

  void _showEditTargetDialog(BuildContext context, String monthYear) {
    TextEditingController controller = TextEditingController(
      text: targetExpenses[monthYear]?.toString() ?? '0',
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Target Expense for $monthYear'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Target Expense'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                double newTarget = double.tryParse(controller.text) ?? 0;
                setState(() {
                  targetExpenses[monthYear] = newTarget;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> monthlyExpenses = _calculateMonthlyExpenses();

    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Expenses', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 106, 255, 255),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: monthlyExpenses.length,
                itemBuilder: (context, index) {
                  String monthYear = monthlyExpenses.keys.elementAt(index);
                  double total = monthlyExpenses[monthYear]!;
                  double target = targetExpenses[monthYear] ?? 0;
                  double progress = (target > 0) ? (total / target).clamp(0.0, 1.0) : 0;
                  bool isOverBudget = total > target;

                  return Card(
                    elevation: 6,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            monthYear,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 5, 12)),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Total: Rs. ${total.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isOverBudget ? Colors.red : Colors.green),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Target: Rs. ${target.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 10, 0, 0)),
                          ),
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[300],
                            color: isOverBudget ? Colors.red : Colors.green,
                          ),
                          SizedBox(height: 6),
                          Text(
                            '${(progress * 100).toStringAsFixed(1)}% of Target',
                            style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 153, 148, 255)),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _showEditTargetDialog(context, monthYear);
                                },
                                child: Text('Edit Target', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 106, 255, 255),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  ' Back to Categories ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 106, 255, 255),
                  padding: EdgeInsets.symmetric(vertical: 14 , horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
