import 'package:flutter/material.dart';

import 'detailedInscription.dart';

class MyInscriptionCard extends StatefulWidget {
  String wid;
  String eventWid;
  String name;
  String image;
  String eventDate;
  String extraData;
  String quantity;
  var participants;
  var inscriptionFields;

  MyInscriptionCard(String wid,
  String eventWid,
  String name,
  String image,
  String eventDate,
  String extraData,
  String quantity,
  var participants,
  var inscriptionFields){
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
  State<StatefulWidget> createState() => _MyInscriptionCardState();
}

class _MyInscriptionCardState extends State<MyInscriptionCard> {
  @override
  Widget build(BuildContext context) {
    String image = widget.image;

    if (image == null) {
      image = "https://images.unsplash.com/photo-1501785888041-af3ef285b470?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80";
    }else{
      image = "https://vueltalpueblo.wisclic.es/files/" + image;
    }
    print(image);

    return Container(
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailedInscription(widget.wid, widget.eventWid, widget.name, image, widget.eventDate, widget.extraData, widget.quantity, widget.participants, widget.inscriptionFields);
          }));
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/loading.gif',
                        image: image,
                        height: 100,
                        fit: BoxFit.cover,
                      )),
                ),
                Padding(padding: EdgeInsets.only(left: 15)),
                Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: Text(
                          widget.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(child: Text("11 de marzo 2020"))
                      ],
                    )),
                Padding(padding: EdgeInsets.only(left: 15)),
                Expanded(
                  flex: 1,
                  child: Chip(
                    backgroundColor: Color(0xFFDAE1F5),
                    label: Text(
                      widget.quantity,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4E67AA)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
