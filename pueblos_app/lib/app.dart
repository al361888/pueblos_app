import 'package:flutter/material.dart';
import 'package:pueblos_app/authService.dart';
import 'package:pueblos_app/screens/homeScreen.dart';
import 'screens/loginScreen.dart';

class App extends StatelessWidget {
  AuthService appAuth = AuthService();

  //Por defecto, la primera vez que inicias la app entras en el login
  Widget _defaultHome = LoginScreen();
  // Get result of the login function.
  bool result = appAuth.login();

  if (result) {
    _defaultHome = new HomeScreen();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _defaultHome,
    );
  }
}