import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/models/Sale.dart';
import 'package:my_first_app/screens/AppStyles.dart';
import 'package:my_first_app/utils/database_helper.dart';


class AddSaleScreen extends StatefulWidget {
  
  @override
  _AddSaleScreenState createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends State<AddSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();



  String _date = DateFormat(dtFormat).format(DateTime.now());

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final sale = Sale(
        desc: _descriptionController.text,
        sales: double.parse(_amountController.text),
        date: _date,
      );

      DatabaseHelper.instance.insertSale(sale).then((id) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sale added with ID: $id')),
        );
        _clearForm();
      });
    }
  }

  void _clearForm() {
    _descriptionController.clear();
    _amountController.clear();
    setState(() {
      _date = DateFormat(dtFormat).format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Sale"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(labelText: 'Date'),
                initialValue: _date,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _date = DateFormat(dtFormat).format(selectedDate);
                    });
                  }
                },
              ),             
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Total Sales'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),              
              TextFormField(
                maxLines: 4, 
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Save Sale'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
