import 'package:flutter/material.dart';
import 'package:pueblos_app/authService.dart';
import 'package:pueblos_app/screens/homeScreen.dart';
import 'package:pueblos_app/screens/loginScreen.dart';
import 'package:pueblos_app/screens/splashScreen.dart';
import 'package:pueblos_app/screens/villageSelector.dart';

class App extends StatelessWidget {
  AuthService appAuth = AuthService();

  /*  //Por defecto, la primera vez que inicias la app entras en el login
  Widget _defaultHome = LoginScreen();
  // Get result of the login function.
  bool result = appAuth.login();

  if (result) {
    _defaultHome = new HomeScreen();
  } */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF0EB768),
        accentColor: Color(0xCC272741),
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/LoginScreen': (BuildContext context) => LoginScreen(),
        '/HomeScreen': (BuildContext context) => HomeScreen(),
        '/VillageSelector': (BuildContext context) => VillageSelector()
      },
    );
  }
}
