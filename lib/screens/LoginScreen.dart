// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/screens/AppStyles.dart';
import 'package:my_first_app/screens/DashboardScreen.dart';
import 'package:my_first_app/screens/Dashborad.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Handle the login logic here
       // Retrieve values from controllers
  String username = _usernameController.text.trim();
  String password = _passwordController.text.trim();

  if (username.isEmpty || password.isEmpty) {
    // Show error if fields are empty
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Username and Password cannot be empty'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  if (username == password) {
    // Navigate to home screen if credentials are valid
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  } else {
    // Show error if credentials are invalid
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid Username or Password'),
        backgroundColor: Colors.red,
      ),
    );
  }
    }
  }

  void _cancel() {
    // Close the app when Cancel is pressed
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 234, 234), 
      // appBar: AppBar(
      //   title: const Text('Login Screen'),
      // ),
      body: Center(
        child: Container(
          width:
              MediaQuery.of(context).size.width * 0.95, // 95% of screen width
          margin: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 10.0), // Add margin
          padding:
              const EdgeInsets.all(16.0), // Optional padding inside the containerr
          decoration: AppStyles.containerDecoration,
          child: Padding(
            padding: const EdgeInsets.all(16.0),            
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Text(
                      'Welcome to Login', 
                      style: TextStyle(fontSize: 40, color: Colors.blue[800] 
                            , fontStyle: FontStyle.normal
                            , fontWeight: FontWeight.bold, 
                      ),
                    ),
                  // Username TextField                  
                  TextFormField(
                    controller: _usernameController,
                    decoration: AppStyles.inputDecoration
                        .copyWith(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Password TextField
                  TextFormField(
                    controller: _passwordController,
                    decoration: AppStyles.inputDecoration
                        .copyWith(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    // Login and Cancel Buttons
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _login,
                          style: AppStyles.loginBtnStyle,
                          child:
                          const Text(
                              'Login', 
                              style: TextStyle(fontSize: 30, color: Colors.white 
                            , fontStyle: FontStyle.normal
                            , fontWeight: FontWeight.normal, 
                      ),
                          ),                          
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
