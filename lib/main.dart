import 'package:flutter/material.dart';
import 'package:my_first_app/screens/AppStyles.dart';
import 'package:my_first_app/screens/Dashborad.dart';
import 'package:my_first_app/screens/LoginScreen.dart';
import 'package:my_first_app/screens/SalesAddScreen.dart';
import 'package:my_first_app/screens/SalesListingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      //theme: AppStyles.darkTheme,
      theme: SlackInspiredTheme.lightTheme(),
      darkTheme: SlackInspiredTheme.darkTheme(),
      themeMode: ThemeMode.system,  // Respects 


      //home: const MyHomePage(title: 'Demo | Home Page'),

      //home: LoginScreen(),
      home: const DashboardScreen(),
      routes: { // Define routes for navigation
        '/sales': (context) => const SalesListingScreen(),
        '/add-sales': (context) => const AddSaleScreen1(),
        '/login': (context) => const LoginScreen(),
      },
//      home: const SalesListingScreen() ,
        );
  }
}

