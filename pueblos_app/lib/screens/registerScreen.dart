import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../authService.dart';
import 'homeScreen.dart';
import 'loginScreen.dart';
import 'villageSelector.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterUserData {
  String username = "";
  String pass = "";
  String email = "";
  String village = "";
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKeyReg = GlobalKey<FormState>();
  _RegisterUserData _registerUserData = _RegisterUserData();
  bool _logged = false;

  _onPressed() async {
    // AuthService authService = AuthService();
    // print("Email: " + _registerUserData.username);
    // await authService.login(_registerUserData.username, _registerUserData.pass).then((result) {
    //   _logged = result;
    // });
    // if (_logged) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => HomeScreen()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _logged ? HomeScreen() : registerForm(),
    );
  }

  Widget registerForm() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Image(
          image: AssetImage("assets/images/landscape.jpg"),
          fit: BoxFit.cover,
        ),
        Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.1, 0.8],
                colors: [Color(0xCC272741), Color(0x00272741)],
              ),
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: 40, top: 20, right: 40, bottom: 20),
              width: 350,
              decoration: BoxDecoration(
                color: Color(0x77090909),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(bottom: 20, top: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Registrarse",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  Theme(
                    data: ThemeData(primaryColor: Colors.white70),
                    child: Form(
                      key: _formKeyReg,
                      autovalidate: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            cursorColor: Theme.of(context).primaryColor,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white70,
                                )),
                                icon: Icon(Icons.perm_identity),
                                hintText: "Nombre de usuario",
                                hintStyle: TextStyle(
                                    color: Colors.white70, fontSize: 18)),
                            keyboardType: TextInputType.text,
                            onChanged: (String value) {
                              this._registerUserData.username = value;
                            },
                          ),
                          Padding(padding: EdgeInsets.only(top: 10.0)),
                          TextFormField(
                              cursorColor: Theme.of(context).primaryColor,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white70,
                                  )),
                                  icon: Icon(Icons.lock_outline),
                                  hintText: "Contraseña",
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 18)),
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              onChanged: (String value) {
                                this._registerUserData.pass = value;
                              }),
                          Padding(padding: EdgeInsets.only(top: 10.0)),
                          TextFormField(
                              cursorColor: Theme.of(context).primaryColor,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white70,
                                  )),
                                  icon: Icon(Icons.email),
                                  hintText: "Correo electrónico",
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 18)),
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              onChanged: (String value) {
                                this._registerUserData.email = value;
                              }),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                          ),
                          Container(
                            width: 380,
                            height: 50,
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: _onPressed,
                              child: Container(
                                  child: Text(
                                "Registrarse",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "¿Ya tienes cuenta? Inicia sesión",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                )),
            Container(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Iniciar sin cuenta",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VillageSelector()));
                  },
                )),
          ],
        ),
      ]),
    );
  }
}
