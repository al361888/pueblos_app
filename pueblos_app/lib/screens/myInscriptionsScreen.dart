import 'package:flutter/material.dart';
import 'package:pueblos_app/components/inscriptions/myInscriptionsContainer.dart';

class MyInscriptionsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyInscriptionsScreenState();
  }
  
  class _MyInscriptionsScreenState extends State<MyInscriptionsScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, title: Text("Mis Inscripciones"),),
      body: Container(
        padding: EdgeInsets.all(20),
        child: MyInscriptionsContainer(),
      ),
    );
  }
}
