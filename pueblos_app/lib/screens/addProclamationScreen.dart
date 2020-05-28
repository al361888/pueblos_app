import 'package:flutter/material.dart';
import 'package:pueblos_app/screens/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authService.dart';
import '../dbService.dart';

class AddProclamationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddProclamationScreenState();
}

class _AddProclamationScreenState extends State<AddProclamationScreen> {
  
  @override
  void initState() {
    super.initState();
    AuthService().refreshToken();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Nuevo bando",
            //style: TextStyle(color: Colors.white),
          )),
      body: Container(
        padding: EdgeInsets.all(20),
        child: NewProclamationForm(),
      ),
    );
  }
}

//Formulario personalizado para la creación de un bando
class NewProclamationForm extends StatefulWidget {
  @override
  NewProclamationFormState createState() {
    return NewProclamationFormState();
  }
}

//Datos sobre los bandos
class _ProclamationData {
  String title = "";
  String description = "";
  String community = "";
}

class NewProclamationFormState extends State<NewProclamationForm> {
  final _formKey = GlobalKey<FormState>();
  _ProclamationData _data = _ProclamationData();
  String dropDownValue = "General";
  String villageId;

  @override
  void initState() {
    super.initState();
    _getVillageId();
  }

  _getVillageId() async{
    final userPrefs = await SharedPreferences.getInstance();
    setState(() {
      villageId = userPrefs.getString('activeVillageId');
    });
  }

  @override
  Widget build(BuildContext context) {
    //Cargar lista de comunidades del pueblo
    //--------------------------------------

    //Formulario
    return Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            TextFormField(
                decoration: new InputDecoration(
                  labelText: "Título",
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Introduce un título para el bando.';
                  }
                  return null;
                },
                onChanged: (String value) {
                  this._data.title = value;
                }),
            Padding(padding: EdgeInsets.only(top: 30)),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Descripción",
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              maxLines: null,
              textAlign: TextAlign.justify,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Introduce una descripción del bando.';
                }
                return null;
              },
              onChanged: (String value) {
                this._data.description = value;
              },
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            DropdownButtonFormField(
              value: dropDownValue,
              decoration: InputDecoration(
                labelText: "Comunidad",
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(),
                ),
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropDownValue = newValue;
                });
              },
              items: <String>['General', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onSaved: (String value) {
                this._data.community = value;
              },
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Container(
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate()) {
                    firebaseAdd(this._data.title, this._data.description,
                        this._data.community, villageId);
                  }
                },
                child: Text(
                  'CREAR',
                  style: TextStyle(fontSize: 20),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
            )
          ],
        ));
  }

  void firebaseAdd(String title, String description, String community, String villageId) {
    var db = DBService(villageId);
    var ret = db.addProclamation(title, description, community);
    if (ret == null) {
      //No se ha creado el bando
      showDialog(context: context, builder: (_) => errorDialog());
    } else {
      showDialog(context: context, builder: (_) => successDialog());
    }
  }

  Widget errorDialog() {
    return AlertDialog(
      title: Center(
          child: Text(
        "¡Error al crear el bando!",
        style: TextStyle(color: Colors.red[600]),
      )),
      content: Text(
        "Ha ocurrido un error al intentar crear el bando. Por favor, inténtalo de nuevo.",
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

  Widget successDialog() {
    return AlertDialog(
      title: Center(
          child: Text(
        "¡Bando creado correctamente!",
        style: TextStyle(color: Theme.of(context).primaryColor),
      )),
      content: Text(
        "Se ha creado el bando de forma satisfactoria. Puedes ver todos los bandos activos en la lista de bandos.",
        textAlign: TextAlign.justify,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Cerrar",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                        '/HomeScreen', (Route<dynamic> route) => false);
          },
        ),
      ],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
