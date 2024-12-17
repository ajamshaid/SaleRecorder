import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:my_first_app/models/Sale.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('sale_recorder.db');

     print('DB connection Successfull: $_database');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    
    print('K is Web: $kIsWeb');

    if (kIsWeb) {
    // Use the web-compatible version of the database factory
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    // Use the standard FFI version for mobile/desktop
    databaseFactory = databaseFactoryFfi;
  }
    final dbPath = await getDatabasesPath();
    final pathWithName = join(dbPath, path);

    print('Going to open DBb: $pathWithName');

     if (!await databaseExists(pathWithName)) {
    // Create database if it doesn't exist
    return await openDatabase(pathWithName, version: 1, onCreate: _createDB);
  } else {
    // Open existing database
    return await openDatabase(pathWithName);
  }    
  }

  Future _createDB(Database db, int version) async {
    const salesTable = '''
      CREATE TABLE sales(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sale_date TEXT NOT NULL,
        total_sales REAL NOT NULL,
        desc TEXT
      )
    ''';

    const expensesTable = '''
      CREATE TABLE expenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        expense_date TEXT NOT NULL,
        category TEXT NOT NULL,
        amount REAL NOT NULL,
        desc TEXT 
      )
    ''';

    const fixedExpensesTable = '''
      CREATE TABLE fixed_expenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        expense_name TEXT NOT NULL,
        amount REAL NOT NULL,
        month INTEGER NOT NULL,
        year INTEGER NOT NULL,
        desc TEXT 
      )
    ''';

    const monthlyReportTable = '''
      CREATE TABLE monthly_reports(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        month INTEGER NOT NULL,
        year INTEGER NOT NULL,
        total_sales REAL NOT NULL,
        total_expenses REAL NOT NULL,
        total_profit REAL NOT NULL,
        desc TEXT 
      )
    ''';

    await db.execute(salesTable);
    await db.execute(expensesTable);
    await db.execute(fixedExpensesTable);
    await db.execute(monthlyReportTable);
  }

  // CRUD Operations for Sales
  Future<int> insertSale(Sale sale) async {
    final db = await instance.database;
    return await db.insert('sales', sale.toMap());
  }


  Future<List<Map<String, dynamic>>> fetchSales() async {
    final db = await instance.database;
    return await db.query('sales');
  }

  // CRUD Operations for Expenses
  Future<int> insertExpense(Map<String, dynamic> expense) async {
    final db = await instance.database;
    return await db.insert('expenses', expense);
  }

  Future<List<Map<String, dynamic>>> fetchExpenses() async {
    final db = await instance.database;
    return await db.query('expenses');
  }

  // CRUD Operations for Fixed Expenses
  Future<int> insertFixedExpense(Map<String, dynamic> expense) async {
    final db = await instance.database;
    return await db.insert('fixed_expenses', expense);
  }

  Future<List<Map<String, dynamic>>> fetchFixedExpenses(int month, int year) async {
    final db = await instance.database;
    return await db.query('fixed_expenses', where: 'month = ? AND year = ?', whereArgs: [month, year]);
  }

  // Monthly Report Calculation
  Future<Map<String, dynamic>> generateMonthlyReport(int month, int year) async {
    final db = await instance.database;

    // Calculate total sales for the month
    final sales = await db.rawQuery('''
      SELECT SUM(total_sales) as total_sales FROM sales 
      WHERE strftime('%m', sale_date) = ? AND strftime('%Y', sale_date) = ?
    ''', ['${month.toString().padLeft(2, '0')}', year.toString()]);

    // Calculate total expenses for the month
    final expenses = await db.rawQuery('''
      SELECT SUM(amount) as total_expenses FROM expenses 
      WHERE strftime('%m', expense_date) = ? AND strftime('%Y', expense_date) = ?
    ''', ['${month.toString().padLeft(2, '0')}', year.toString()]);

    // Get fixed expenses for the month
    final fixedExpenses = await fetchFixedExpenses(month, year);

    double totalFixedExpenses = 0.0;
    for (var expense in fixedExpenses) {
      totalFixedExpenses += expense['amount'];
    }

    // Calculate profit/loss
    final totalSales = sales.isNotEmpty ? sales[0]['total_sales'] ?? 0.0 : 0.0;
    final totalExpenses = expenses.isNotEmpty ? expenses[0]['total_expenses'] ?? 0.0 : 0.0;

    final profitLoss = (totalSales as double) - ((totalExpenses as double) + totalFixedExpenses);

    return {
      'total_sales': totalSales,
      'total_expenses': totalExpenses + totalFixedExpenses,
      'total_profit_loss': profitLoss
    };
  }
}
