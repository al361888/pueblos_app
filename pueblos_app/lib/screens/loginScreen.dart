import 'package:flutter/material.dart';
import 'package:pueblos_app/screens/homeScreen.dart';
import 'package:pueblos_app/authService.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _UserData {
  String email = "";
  String pass = "";
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey1 = GlobalKey<FormState>();
  _UserData _userData = _UserData();
  bool _logged = false;

  _onPressed() async {
    AuthService authService = AuthService();
    print("Email: " + _userData.email);
    await authService.login(_userData.email, _userData.pass).then((result) {
      _logged = result;
    });
    if (_logged) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _logged ? HomeScreen() : loginForm(),
    );
  }

  Widget loginForm() {
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
                        "Iniciar Sesión",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white70
                    ),
                    child: Form(
                      key: _formKey1,
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
                              this._userData.email = value;
                            },
                          ),
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
                                this._userData.pass = value;
                              }),
                          Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                          ),
                          Container(
                            width: 380,
                            height: 50,
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: _onPressed,
                              child: Container(
                                  child: Text(
                                "Acceder",
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
                    "¿No tienes cuenta? Regístrate",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {},
                )),
          ],
        ),
      ]),
    );
  }
}
