import 'package:flutter/material.dart';

class AddProclamationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddProclamationScreenState();
}

class _AddProclamationScreenState extends State<AddProclamationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crear nuevo bando")),
      body: Container(
        padding: EdgeInsets.all(20),
        child: NewProclamationForm(),
      ),
    );
  }
}

// Define a custom Form widget.
class NewProclamationForm extends StatefulWidget {
  @override
  NewProclamationFormState createState() {
    return NewProclamationFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class NewProclamationFormState extends State<NewProclamationForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Título:"),
            TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Introduce un título para el bando.';
                }
                return null;
              },
            ),
            Text("Descripción:"),
            TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Introduce una descripción del bando.';
                }
                return null;
              },
            ),
            Text("Comunidad:"),
            DropdownButtonFormField(items: null, 
            onChanged: null),
            RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            )
          ],
        ));
  }
}
