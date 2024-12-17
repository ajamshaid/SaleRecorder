class Sale {
  final int? id;
  final String desc;
  final double sales;
  final String date;

  Sale({this.id, required this.desc, required this.sales, required this.date});

  // Convert Sale object to a map for inserting into SQLite
  Map<String, dynamic> toMap() {
    return {
      'desc': desc,
      'total_sales': sales,
      'sale_date': date,
    };
  }

  // Convert Map to Sale object
  static Sale fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map['id'],
      desc: map['desc'],
      sales: map['total_sales'],
      date: map['sale_date'],
    );
  }
}
