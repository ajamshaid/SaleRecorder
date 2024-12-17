import 'package:flutter/material.dart';
import 'package:my_first_app/screens/AppStyles.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Number of columns
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 1.2, // Adjust aspect ratio for card size
          children: <Widget>[
            DashboardCard(
              title: 'Total Sales',
              value: '\$10,000',
              icon: Icons.monetization_on,
              color: Colors.blue,
              onTap:() {
                Navigator.pushNamed(context, '/sales');
              }
             ),
             DashboardCard(
              title: 'New Users',
              value: '500',
              icon: Icons.person_add,
              color: Colors.green,
               onTap:() {
                Navigator.pushNamed(context, '/sales');
              }
            ),
             DashboardCard(
              title: 'Active Users',
              value: '250',
              icon: Icons.people,
              color: Colors.orange,
               onTap:() {
                Navigator.pushNamed(context, '/sales');
              }
            ),
             DashboardCard(
              title: 'Orders',
              value: '120',
              icon: Icons.shopping_cart,
              color: Colors.purple,
               onTap:() {
                Navigator.pushNamed(context, '/sales');
              }
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap; // Add onTap callback

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap, // Make onTap required
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( // Use InkWell for tap detection and ripple effect
      onTap: onTap,
      child: 
     Card(
      elevation: 200.0,
      color: AppStyles.appPrimaryMaterialColor[50],
      shadowColor: AppStyles.appPrimaryMaterialColor[500],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 40.0,
              color: color,
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              value,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    ));
  }
}