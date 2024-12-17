import 'package:flutter/material.dart';
import 'package:my_first_app/utils/database_helper.dart';


// void main() {
//   runApp(MyApp());
// }

class SaleExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FinancialScreen(),
    );
  }
}

class FinancialScreen extends StatefulWidget {
  @override
  _FinancialScreenState createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> {
  final TextEditingController _salesController = TextEditingController();
  final TextEditingController _expenseController = TextEditingController();

  Future<void> _addSale() async {
    final sale = {
      'sale_date': DateTime.now().toString(),
      'total_sales': double.parse(_salesController.text),
    };
 //   await DatabaseHelper.instance.insertSale(sale);
    _salesController.clear();
  }

  Future<void> _addExpense() async {
    final expense = {
      'expense_date': DateTime.now().toString(),
      'category': 'Food',  // This can be dynamic
      'amount': double.parse(_expenseController.text),
    };
    await DatabaseHelper.instance.insertExpense(expense);
    _expenseController.clear();
  }

  Future<void> _generateReport() async {
    final report = await DatabaseHelper.instance.generateMonthlyReport(12, 2024);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Monthly Report'),
        content: Text(
            'Total Sales: ${report['total_sales']}\nTotal Expenses: ${report['total_expenses']}\nProfit/Loss: ${report['total_profit_loss']}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Restaurant Finance Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _salesController,
              decoration: InputDecoration(labelText: 'Daily Sales'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _expenseController,
              decoration: InputDecoration(labelText: 'Daily Expense'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addSale,
              child: Text('Add Sale'),
            ),
            ElevatedButton(
              onPressed: _addExpense,
              child: Text('Add Expense'),
            ),
            ElevatedButton(
              onPressed: _generateReport,
              child: Text('Generate Monthly Report'),
            ),
          ],
        ),
      ),
    );
  }
}
