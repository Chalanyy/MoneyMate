import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'HeaderWidget.dart';
import 'TotalScreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Map<String, dynamic>> _expenses = [];
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  int? _editIndex;

  double getTotalExpenses() {
    return _expenses.fold(0, (sum, item) => sum + item['amount']);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        ) ??
        _selectedDate;

    setState(() {
      _selectedDate = picked;
    });
  }

  Color _getColorBasedOnAmount(double amount) {
    if (amount <= 500) {
      return Color.fromARGB(255, 153, 148, 255);
    } else if (amount <= 1000) {
      return Color.fromARGB(255, 106, 102, 177);
    } else if (amount <= 1500) {
      return Color.fromARGB(255, 78, 75, 131);
    } else if (amount <= 2000) {
      return Color.fromARGB(255, 200, 162, 200);
    } else {
      return Color.fromARGB(255, 220, 190, 255);
    }
  }

  void _showExpenseDialog(String category, double amount, DateTime date) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Expense Added'),
          content: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Category: $category'),
                    Text('Amount: Rs. ${amount.toStringAsFixed(2)}'),
                    Text('Date: ${date.toString()}'),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _addOrUpdateExpense() {
    String category = _categoryController.text.trim();
    double? amount = double.tryParse(_amountController.text);

    if (category.isNotEmpty && amount != null && amount > 0) {
      setState(() {
        if (_editIndex == null) {
          _expenses.add({
            'category': category,
            'amount': amount,
            'date': _selectedDate,
            'color': _getColorBasedOnAmount(amount),
          });
        } else {
          _expenses[_editIndex!] = {
            'category': category,
            'amount': amount,
            'date': _selectedDate,
            'color': _getColorBasedOnAmount(amount),
          };
          _editIndex = null;
        }
      });

      _showExpenseDialog(category, amount, _selectedDate);

      _categoryController.clear();
      _amountController.clear();
    }
  }

  void _deleteExpense(int index) {
    setState(() {
      _expenses.removeAt(index);
    });
  }

  void _editExpense(int index) {
    setState(() {
      _editIndex = index;
      _categoryController.text = _expenses[index]['category'];
      _amountController.text = _expenses[index]['amount'].toString();
      _selectedDate = _expenses[index]['date'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Categories', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 106, 255, 255),
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView( // Entire screen scrollable
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            children: [
              HeaderWidget(),
              SizedBox(height: 5),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TotalScreen(
                        totalAmount: getTotalExpenses(),
                        expenses: _expenses,
                      ),
                    ),
                  );
                },
              
                label: Text(
                  'View Total Expenses',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 121, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: screenWidth * 0.04),
                  elevation: 5,
                ),
              ),
              SizedBox(height: 10),
              // Removed card, now form is directly inside the scrollable column
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: 'Amount (Rs.)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}"),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _addOrUpdateExpense,
                      icon: Icon(_editIndex == null ? Icons.add : Icons.edit, size: 24),
                      label: Text(
                        _editIndex == null ? 'Add Expense' : 'Update Expense',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 106, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: screenWidth * 0.04),
                        elevation: 5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // List of added categories, also part of scrollable content
              Column(
                children: _expenses.map((expense) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    color: expense['color'],
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        expense['category'],
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                      ),
                      subtitle: Text(
                        'Rs. ${expense['amount'].toStringAsFixed(2)}\nDate: ${DateFormat('yyyy-MM-dd').format(expense['date'])}',
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () => _editExpense(_expenses.indexOf(expense)),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.white),
                            onPressed: () => _deleteExpense(_expenses.indexOf(expense)),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
