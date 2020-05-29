import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:pueblos_app/apiCalls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authService.dart';

class SpecificInscriptionContainer extends StatefulWidget {
  String wid;
  String username;
  String image;
  String quantity;
  String eventWid;
  String eventDate;
  String extraData;
  var inscriptionFields;
  var participants;

  SpecificInscriptionContainer(
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
  State<StatefulWidget> createState() => _SpecificInscriptionContainerState();
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
    this.isConfirmed,
    this.participantWid,
    this.participantIndex
  });

  var expandedValue;
  String headerValue;
  bool isExpanded;
  bool isConfirmed;
  String participantWid;
  int participantIndex;
}

List<Item> generateItems(
    int numberOfItems, String extraData, var participants, var specificFields) {
  return List.generate(numberOfItems, (int index) {
    var participant = participants[index];
    var partExtraData = participant['extraData'];
    var dataMap = json.decode(partExtraData);
    var confirmed;

    if (participant['isUsed'] == '1') {
      confirmed = true;
    } else {
      confirmed = false;
    }

    print(participant['isUsed'] + "------------> "+ confirmed.toString());
    var list = List<Widget>();
    for (var i in specificFields) {
      String value;
      if (dataMap[i["name"]] == null) {
        value = "No";
      } else if (dataMap[i["name"]] == "0") {
        value = "No";
      } else if (dataMap[i["name"]] == "1") {
        value = "Sí";
      } else if (dataMap[i["name"]] == "") {
        value = "No";
      } else {
        value = dataMap[i["name"]];
      }
      Widget row = Row(
        children: <Widget>[
          Text(
            i["label"],
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 18, height: 1.5),
          ),
          Padding(padding: EdgeInsets.only(left: 5)),
          Text(
            value,
            style: TextStyle(fontSize: 18, height: 1.5),
          ),
        ],
      );
      list.add(row);
    }
    return Item(
        headerValue: participant['name'],
        expandedValue: list,
        participantWid: participant['wid'],
        isConfirmed: confirmed,
        participantIndex: index);
  });
}

class _SpecificInscriptionContainerState
    extends State<SpecificInscriptionContainer> {
  var _data;
  Map fields;
  var specificFields;

  @override
  void initState() {
    super.initState();
    AuthService().refreshToken();
    setState(() {
      fields = json.decode(widget.inscriptionFields);
      specificFields = fields['specificFields'];
      _data = generateItems(int.parse(widget.quantity), widget.extraData,
          widget.participants, specificFields);
    });
  }

  @override
  Widget build(BuildContext context) {
    String inscriptionAsistants = widget.quantity;

    String image = widget.image;
    if (image == null) {
      image = "https://eu.ui-avatars.com/api/?name=" + widget.username;
    } else {
      image = "https://vueltalpueblo.wisclic.es/files/" + image;
    }

    return SingleChildScrollView(
        child: Column(children: <Widget>[
      Container(
        height: 50,
        child: Row(
          //Searchbar y filtros
          children: <Widget>[
            Container(
                child: Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () => print("Searched"),
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            )),
            Padding(padding: EdgeInsets.only(left: 10)),
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.center_focus_weak,
                  size: 32,
                ),
                onPressed: scan,
              ),
            )
          ],
        ),
      ),
      Padding(padding: EdgeInsets.only(top: 30)),
      Row(children: <Widget>[
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
              ]),
        ),
      ]),
      Padding(padding: EdgeInsets.only(top: 30)),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          inscriptionAsistants + " Asistentes",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xFF1E2C41)),
        ),
      ),
      Padding(padding: EdgeInsets.only(top: 20)),
      _buildPanel()
    ]));
  }

  Widget _buildPanel() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _data[index].isExpanded = !isExpanded;
          });
        },
        children: _data.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: <Widget>[
                      item.isConfirmed
                          ? Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            )
                          : Icon(Icons.remove_circle),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        item.headerValue,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E2C41)),
                      ),
                    ],
                  ),
                ),
              );
            },
            body: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: item.expandedValue,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: RaisedButton(
                          color: Color(0xFFDF4674),
                          child: Container(
                              child: Text(
                            "Confirmar asistencia",
                            style: TextStyle(color: Colors.white),
                          )),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          onPressed: () {
                            setState(() {
                              item.isConfirmed = !item.isConfirmed;
                              item.isExpanded = false;
                            });
                            confirm(item.participantWid, item.isConfirmed);
                            item.isConfirmed?widget.participants[item.participantIndex]['isUsed']='1':widget.participants[item.participantIndex]['isUsed']='0';
                          })),
                ],
              ),
            ),
            isExpanded: item.isExpanded,
          );
        }).toList(),
      ),
    );
  }

  Future<void> confirm(String participantWid, bool isConfirmed) async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    String token = userPrefs.getString('token');
    String activeVillageWid = userPrefs.getString('activeVillageId');
    String isUsed;
    if (isConfirmed) {
      isUsed = '1';
    } else {
      isUsed = '0';
    }
    ApiCalls().confirmParticipant(
        activeVillageWid, widget.eventWid, participantWid, isUsed, token).then((response) => print(response.body));
  }

  Future scan() async {
    try {
      var result = await BarcodeScanner.scan();
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
    }
  }
}
