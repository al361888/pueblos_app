import 'dart:async';
import 'package:pueblos_app/authService.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), _onShowLogin);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _onShowLogin() async {
    bool firstLogin = true;
    await AuthService().checkFirstLogin().then((result) {
      firstLogin = result;
    });

    if (firstLogin) {
      Navigator.of(context).pushReplacementNamed('/LoginScreen');
    } else {
      Navigator.of(context).pushReplacementNamed('/HomeScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        //decoration: ,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Image.asset("assets/images/escudo.png", width: 40, height: 40),
            Flexible(
              flex: 2,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 64.0, horizontal: 16.0),
                  alignment: Alignment.bottomCenter,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
              ),
            ),
            Container(child: Text('Created By Wisclic Tech'),)
          ],
        ),
      ),
    );
  }
}
