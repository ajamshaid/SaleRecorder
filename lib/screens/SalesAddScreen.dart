import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/models/Sale.dart';
import 'package:my_first_app/screens/AddSaleScreen.dart';
import 'package:my_first_app/screens/AppStyles.dart';
import 'package:my_first_app/utils/database_helper.dart';
class AddSaleScreen1 extends StatefulWidget {
  const AddSaleScreen1({Key? key}) : super(key: key);

  @override
  State<AddSaleScreen1> createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends State<AddSaleScreen1> {
  final _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();
  final _salesController = TextEditingController();
  final _dateController = TextEditingController();

  DateTime _selectedDate = DateTime.now(); // Initialize with current date;

  @override
  void dispose() {
    _descController.dispose();
    _salesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

@override
  void initState() {
    super.initState();
    _dateController.text = DateFormat(dtFormat).format(_selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate:  DateTime.now(), // Restrict to past and present dates,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat(dtFormat).format(picked); // Format the date
      });
    }
  }


  Future<void> _addSale() async {
    if (_formKey.currentState!.validate()) {
       if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a date.')),
        );
        return; // Stop if date is not selected
      }
      final newSale = Sale(
        desc: _descController.text,
        sales: double.parse(_salesController.text),
        date: _dateController.text,
      );

      ///await Future.delayed(const Duration(seconds: 1));

       DatabaseHelper.instance.insertSale(newSale).then((id) {       
 // Show confirmation dialog
 // Format the sales amount to currency with commas
      final formattedSales = AppUtils.formatCurrency(newSale.sales);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Sale Recorded'),
          content: Text('Sale of Amount [$formattedSales] added successfully!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
       _clearForm();
      }
      );
    }
  }

  void _clearForm() {
    _descController.clear();
      _salesController.clear();
      _dateController.clear();
      _selectedDate = DateTime.now(); // Reset to current date
      _dateController.text = DateFormat(dtFormat).format(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [         
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _dateController,
                readOnly: true, // Prevent manual editing
                decoration: const InputDecoration(
                  labelText: 'Date',
                  suffixIcon: Icon(Icons.calendar_today), // Add a calendar icon
                ),
                onTap: () => _selectDate(context), // Open date picker on tap
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),     
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _salesController,
                 keyboardType: const TextInputType.numberWithOptions(decimal: true), // Allow decimals
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), // Allow digits and one decimal point
                  ],
                decoration: const InputDecoration(
                  labelText: 'Sales Amount',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sales amount';
                  }
                   if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),       
              const SizedBox(height: 16.0),       
              TextFormField(
                controller: _descController,    
                minLines: 3, // Set this
                maxLines: 6, // and this
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),                
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _addSale,
                child: const Text('Add Sale'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}