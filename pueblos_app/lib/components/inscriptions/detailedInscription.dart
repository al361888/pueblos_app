import 'dart:convert';

import 'package:flutter/material.dart';

class DetailedInscription extends StatefulWidget {
  String wid;
  String eventWid;
  String name;
  String image;
  String eventDate;
  String extraData;
  String quantity;
  var participants;
  var inscriptionFields;

  DetailedInscription(
      String wid,
      String eventWid,
      String name,
      String image,
      String eventDate,
      String extraData,
      String quantity,
      var participants,
      var inscriptionFields) {
    this.wid = wid;
    this.eventWid = eventWid;
    this.name = name;
    this.image = image;
    this.eventDate = eventDate;
    this.extraData = extraData;
    this.quantity = quantity;
    this.participants = participants;
    this.inscriptionFields = inscriptionFields;
  }

  @override
  State<StatefulWidget> createState() => _DetailedInscriptionState();
}

class _DetailedInscriptionState extends State<DetailedInscription> {
  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    String eventDate = widget.eventDate;
    String image = widget.image;

    var participants = widget.participants;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 125,
              width: 500,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              eventDate,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.grey),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: participants.length,
                  itemBuilder: (context, index) {
                    return CodeCard(
                        participants[index], widget.inscriptionFields);
                  }),
            )
          ],
        ),
      )),
    );
  }
}

class CodeCard extends StatelessWidget {
  var participant;
  String name;
  String code;
  String extraData;
  var inscriptionFields;

  CodeCard(var participant, var inscriptionFields) {
    this.participant = participant;
    this.name = participant["name"];
    this.code = participant["code"];
    this.extraData = participant["extraData"];
    this.inscriptionFields = inscriptionFields;
  }

  @override
  Widget build(BuildContext context) {
    Map fields = json.decode(inscriptionFields);
    var specificFields = fields['specificFields'];
    Map userExtraData = json.decode(extraData);

    String qr;

    if(code != null){
      qr = "https://chart.googleapis.com/chart?cht=qr&chs=360x360&chld=M&chl="+code;
    }else{
      qr = "https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1811/pavelstasevich181101032/112815935-stock-vector-no-image-available-icon-flat-vector-illustration.jpg?ver=6";
    }
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(qr,
            width: 350,
            height: 300,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Nombre: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 1.5)),
                    Text(name,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: inscriptionFieldsList(specificFields, userExtraData),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> inscriptionFieldsList(var specificFields, var extraData) {
    List<Widget> list = List();
    for (var i in specificFields) {
      list.add(Row(
        children: <Widget>[
          Text(
            i["label"],
            style:
                TextStyle(fontWeight: FontWeight.w500, fontSize: 18, height: 1.5),
          ),
          Padding(padding: EdgeInsets.only(left:5)),
          Text(
            extraData[i["name"]],
            style:
                TextStyle(fontSize: 18, height: 1.5),
          ),
        ],
      ));
    }
    return list;
  }
}
