import 'package:flutter/material.dart';
import 'package:pueblos_app/screens/homeScreen.dart';

class AddProclamationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddProclamationScreenState();
}

class _AddProclamationScreenState extends State<AddProclamationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crear nuevo bando", style: TextStyle(color: Colors.white),)),
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
            RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  submit();
                }
              },
              child: Text('CREAR'),
              color: Color(0xFF29BF79),
              textColor: Colors.white,
            )
          ],
        ));
  }

  void submit() {
    print(_data.title);
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Processing Data')));
        Navigator.pop(context);
  }
}
