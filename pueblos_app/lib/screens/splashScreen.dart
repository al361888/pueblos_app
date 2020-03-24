import 'dart:async';
import 'package:pueblos_app/authService.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  // @override
  // void initState() {
  //   super.initState();
  //   _timer = Timer(const Duration(seconds: 2), _onShowLogin);
  // }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }

  // Future<void> _onShowLogin() async {
  //   bool firstLogin = true;
  //   await AuthService().checkFirstLogin().then((result) {
  //     firstLogin = result;
  //   });

  //   if (firstLogin) {
  //     Navigator.of(context).pushReplacementNamed('/LoginScreen');
  //   } else {
  //     Navigator.of(context).pushReplacementNamed('/HomeScreen');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.1, 0.8],
                colors: [Color(0xCC272741), Color(0x00272741)],
              ),
            ),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical: 100)),
              Container(
                  child: Image.asset("assets/images/escudo.png",
                      width: 200, height: 200)),
              Flexible(
                flex: 2,
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 100.0, horizontal: 16.0),
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.only(bottom: 20),
              //   child: Text('Created By Wisclic Tech', style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 18,
              //     fontWeight: FontWeight.w600
              //   ),))
            ],
          ),
        ),
      ),
    );
  }
}
