import 'package:flutter/material.dart';
import 'package:my_first_app/screens/AddSaleScreen.dart';
import 'package:my_first_app/screens/AppStyles.dart';
import 'package:my_first_app/utils/database_helper.dart';

class SalesListingScreen extends StatefulWidget {
  const SalesListingScreen({super.key});

  @override
  _SalesListingScreenState createState() => _SalesListingScreenState();
}

class _SalesListingScreenState extends State<SalesListingScreen> {
  List<Map<String, dynamic>> _sales = [];

  // Fetch sales data from the database
  @override
  void initState() {
    super.initState();
    _loadSales();
  }

  Future<void> _loadSales() async {
    final salesData = await DatabaseHelper.instance.fetchSales();
    print('Total Sales Loaded: $salesData.size');
    setState(() {
      _sales = salesData;
    });
  }

  void _addSales() {
    // Navigate to Add Sales screen
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => AddSaleScreen()),
    // );

    Navigator.pushNamed(context, "/add-sales");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
        appBar: AppBar(
          title: Text('Listing'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
              padding: const EdgeInsets.only(bottom: 2.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
              TransparentFab(
                tooltip: "Add New Sales",
                onPressed: () {
                  _addSales();
                },
              )
                ]
              )),
              Expanded(
                  child: Container(
                      width: double.infinity,                       
                      child: _sales.isEmpty
                          ? Text('List is Empty...!')
                          : DataTable(
                                      columns: const [
                                        DataColumn(     
                                          headingRowAlignment: MainAxisAlignment.center,                                     
                                          label:Text('Date',style: TextStyle(fontWeight:FontWeight.bold))
                                          ),
                                        DataColumn(
                                          headingRowAlignment: MainAxisAlignment.end,                                     
                                          label: Text('Sale', textAlign: TextAlign.end,
                                                style: TextStyle(fontWeight:FontWeight.bold))),
                                        DataColumn(
                                            label: Text('Description',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                      rows: List.generate(
                                          _sales.length,
                                          (index) => DataRow(
                                                color: index % 2 != 0
                                                    ? WidgetStateProperty.all(
                                                      Colors.purple[50],
                                                        )
                                                    : WidgetStateProperty.all(
                                                        Colors.white),
                                                cells: [
                                                  DataCell( Align(
                                                              alignment: Alignment.center,
                                                              child:Text(_sales[index]['sale_date'],textAlign: TextAlign.center))),
                                                  DataCell( Align(
                                                              alignment: Alignment.centerRight,
                                                              child: Text(AppUtils.formatCurrency( _sales[index]['total_sales']),textAlign: TextAlign.end))),
                                                  DataCell(Text(_sales[index]['desc'])),
                                                ],
                                              )))))
            ]));
  }
}
