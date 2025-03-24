import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import for DateFormat

class Expense {
  final String title;
  final double amount;
  final DateTime date;

  Expense({required this.title, required this.amount, required this.date});
}

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem(this.expense);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.title),
      subtitle: Text('Rs. ${expense.amount.toString()}'),
      trailing: Text(DateFormat.yMd().format(expense.date)),  // Display the date here
    );
  }
}
