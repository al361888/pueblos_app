import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pueblos_app/model/village.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apiCalls.dart';
import 'homeScreen.dart';

class RegisteredVillageSelector extends StatefulWidget {
  @override
  _RegisteredVillageSelectorState createState() =>
      _RegisteredVillageSelectorState();
}

class _VillageData {
  String villageName;
}

class _RegisteredVillageSelectorState extends State<RegisteredVillageSelector> {
  final _formKeyVillage1 = GlobalKey<FormState>();
  _VillageData _villageData = _VillageData();
  String selectedVillage;
  var villages = List<Village>();
  List<String> villageNames = [];

  _getVillages() async {
    ApiCalls().getVillages().then((response) {
      if (response.statusCode == 200) {
        setState(() {
          Iterable list = json.decode(response.body)['data'];
          villages = list.map((model) => Village.fromJson(model)).toList();
          for (Village village in villages) {
            villageNames.add(village.name);
          }
        });
      } else {
        _getVillages();
      }
    });
  }

  @override
  initState() {
    super.initState();
    _getVillages();
  }

  dispose() {
    super.dispose();
  }

  _onPressed() async {
    var choosedVillage;

    for (Village v in villages) {
      if (v.name == selectedVillage) {
        choosedVillage = v;
        final userPrefs = await SharedPreferences.getInstance();
        userPrefs.setString('activeVillageName', choosedVillage.name);
        userPrefs.setString('activeVillageId', choosedVillage.id);
        userPrefs.setString('activeVillageImage', choosedVillage.image);
        userPrefs.setString('activeVillageUrl', choosedVillage.nameUrl);
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
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
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Escoge un pueblo",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )),
                    Theme(
                      data: ThemeData(
                          primaryColor: Colors.white,
                          canvasColor: Color(0xBB090909)),
                      child: Form(
                        key: _formKeyVillage1,
                        autovalidate: true,
                        child: Column(
                          children: <Widget>[
                            DropdownButtonFormField(
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                              style: TextStyle(fontSize: 20),
                              value: selectedVillage,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                labelText: "Pueblo",
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  selectedVillage = newValue;
                                });
                              },
                              items: villageNames.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onSaved: (String value) {
                                this._villageData.villageName = value;
                              },
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Elige un pueblo para continuar';
                                }
                                return null;
                              },
                            ),
                            Padding(padding: EdgeInsets.only(top: 40)),
                            Container(
                              width: 380,
                              height: 50,
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  if (selectedVillage != null) {
                                    _onPressed();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) => validationWidget());
                                  }
                                },
                                child: Container(
                                    child: Text(
                                  "Continuar",
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
            ],
          )
        ],
      ),
    );
  }

  Widget validationWidget() {
    return AlertDialog(
      title: Center(
          child: Text(
        "¡Error al escoger un pueblo!",
        style: TextStyle(color: Colors.red[600]),
      )),
      content: Text(
        "No has seleccionado ningún pueblo. Por favor, selecciona un pueblo de la lista para poder continuar.",
        textAlign: TextAlign.justify,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Reintentar",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
