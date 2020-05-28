import 'package:flutter/material.dart';
import 'package:pueblos_app/screens/inscriptions/specificInscriptionScreen.dart';

class InscriptionCard extends StatefulWidget {
  String username;
  String image;
  String quantity;
  String eventWid;
  String eventDate;
  String extraData;
  var inscriptionFields;
  var participants;

  InscriptionCard(
      String name,
      String image,
      String quantity,
      String eventWid,
      String eventDate,
      String extraData,
      var inscriptionFields,
      var participants) {
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
  State<StatefulWidget> createState() => _InscriptionCardState();
}

class _InscriptionCardState extends State<InscriptionCard> {
  @override
  Widget build(BuildContext context) {
    String image = widget.image;
    if (image == null) {
      image = "https://eu.ui-avatars.com/api/?name=" + widget.username;
    } else {
      image = "https://vueltalpueblo.wisclic.es/files/" + image;
    }
    return Container(
      child: Card(
        elevation: 3,
        child: InkWell(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Container(
                    width: 55,
                    height: 55,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill, image: new NetworkImage(image)))),
                Padding(padding: EdgeInsets.only(left: 20)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          widget.username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Container(
                        child: Text(
                          widget.username,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                        child: Text(
                          widget.eventDate,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Chip(
                  backgroundColor: Color(0xFFDAE1F5),
                  label: Text(
                    widget.quantity,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF4E67AA)),
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SpecificInscriptionScreen(
                        widget.username,
                        widget.image,
                        widget.quantity,
                        widget.eventWid,
                        widget.eventDate,
                        widget.extraData,
                        widget.inscriptionFields,
                        widget.participants)));
          },
        ),
      ),
    );
  }
}
