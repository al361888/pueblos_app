import 'package:flutter/material.dart';
import 'package:pueblos_app/authService.dart';
import 'package:pueblos_app/components/inscriptions/specificInscriptionContainer.dart';

class SpecificInscriptionScreen extends StatefulWidget {
  String wid;
  String username;
  String image;
  String quantity;
  String eventWid;
  String eventDate;
  String extraData;
  var inscriptionFields;
  var participants;

  SpecificInscriptionScreen(
      String wid,
      String name,
      String image,
      String quantity,
      String eventWid,
      String eventDate,
      String extraData,
      var inscriptionFields,
      var participants) {
    this.wid = wid;
    this.username = name;
    this.image = image;
    this.quantity = quantity;
    this.eventWid = eventWid;
    this.eventDate = eventDate;
    this.extraData = extraData;
    this.inscriptionFields = inscriptionFields;
    this.participants = participants;
  }

  @override
  State<StatefulWidget> createState() => _SpecificInscriptionScreen();
}

class _SpecificInscriptionScreen extends State<SpecificInscriptionScreen> {
  @override
  void initState() {
    super.initState();
    AuthService().refreshToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SpecificInscriptionContainer(
            widget.wid,
            widget.username,
            widget.image,
            widget.quantity,
            widget.eventWid,
            widget.eventDate,
            widget.extraData,
            widget.inscriptionFields,
            widget.participants),
      ),
    );
  }
}
