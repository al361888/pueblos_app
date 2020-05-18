import 'package:flutter/material.dart';
import 'package:pueblos_app/components/events/specificInscriptionContainer.dart';

class SpecificInscriptionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpecificInscriptionScreen();
}

class _SpecificInscriptionScreen extends State<SpecificInscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SpecificInscriptionContainer(),
      ),
    );
  }
}