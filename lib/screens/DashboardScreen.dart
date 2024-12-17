import 'package:flutter/material.dart';

class DashboardScreen1 extends StatefulWidget {
  const DashboardScreen1({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen1> {
  String _selectedMenu = 'Home'; // Default selected menu item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer Header
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/av_default.webp'), 
                  ),
                  SizedBox(height: 10),
                  Text(
                    'AJ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'aj@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Menu Items
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                setState(() {
                  _selectedMenu = 'Home';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Reports'),
              onTap: () {
                setState(() {
                  _selectedMenu = 'Reports';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                setState(() {
                  _selectedMenu = 'Settings';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context); // Exit to Login Screen
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _buildDashboardContent(),
      ),
    );
  }

  Widget _buildDashboardContent() {
    switch (_selectedMenu) {
      case 'Home':
        return const Text(
          'Welcome to the Home Page',
          style: TextStyle(fontSize: 24),
        );
      case 'Reports':
        return const Text(
          'Reports Section',
          style: TextStyle(fontSize: 24),
        );
      case 'Settings':
        return const Text(
          'Settings Section',
          style: TextStyle(fontSize: 24),
        );
      default:
        return const Text(
          'Welcome to the Dashboard',
          style: TextStyle(fontSize: 24),
        );
    }
  }
}
