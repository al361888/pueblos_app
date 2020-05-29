import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pueblos_app/model/inscription.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:pueblos_app/screens/inscriptions/specificInscriptionScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiCalls.dart';
import '../../authService.dart';
import 'inscriptionCard.dart';

class InscriptionsContainer extends StatefulWidget {
  String eventWid;

  InscriptionsContainer(String eventWid) {
    this.eventWid = eventWid;
  }

  @override
  State<StatefulWidget> createState() => _InscriptionsContainerState();
}

class _InscriptionsContainerState extends State<InscriptionsContainer> {
  final myController = TextEditingController();
  var inscriptions = List<Inscription>();
  var codesMap = Map<String, String>();
  

  // String inscriptionsNum = inscriptions.length;
  bool isLoading = true;
  String token;
  String activeVillageWid;

  int totalAsistants = 0;
  String inscriptionsNum;

  @override
  void initState() {
    super.initState();
    _getAsistants();
    AuthService().refreshToken();
  }

  _getAsistants() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    token = userPrefs.getString('token');
    activeVillageWid = userPrefs.getString('activeVillageId');

    ApiCalls()
        .getEventInscriptions(activeVillageWid, widget.eventWid, token)
        .then((response) {
      if (response.statusCode == 200) {
        setState(() {
          Iterable list = json.decode(response.body)['data'];
          inscriptions =
              list.map((model) => Inscription.fromJson(model)).toList();
          inscriptionsNum = inscriptions.length.toString();
        });

        for (var inscription in inscriptions) {
          setState(() {
            totalAsistants+=int.parse(inscription.quantity);
          });
          for (int i = 0; i < int.parse(inscription.quantity); i++) {
            if (inscription.participants[i]['code'] != null) {
              print(inscription.participants[i]['code']);
              setState(() {
                codesMap.putIfAbsent(
                    inscription.participants[i]['code'], () => inscription.wid);
              });
            }
          }
        }

        isLoading = false;
      } else {
        _getAsistants();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  child: Row(
                    //Searchbar y filtros
                    children: <Widget>[
                      Container(
                          child: Expanded(
                        child: TextField(
                          controller: myController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                search(myController.text);
                              },
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
                Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 120,
                        decoration: BoxDecoration(
                          color: Color(0xFFDAE1F5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                inscriptionsNum,
                                style: TextStyle(
                                    color: Color(0xFF4E67AA),
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5)),
                            Container(
                              child: Text(
                                "Inscripciones",
                                style: TextStyle(color: Color(0xFF4E67AA)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 120,
                        decoration: BoxDecoration(
                          color: Color(0xFFDAE1F5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                totalAsistants.toString(),
                                style: TextStyle(
                                    color: Color(0xFF4E67AA),
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5)),
                            Container(
                              child: Text(
                                "Asistentes totales",
                                style: TextStyle(color: Color(0xFF4E67AA)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                Expanded(
                    child: ListView.builder(
                        itemCount: inscriptions.length,
                        itemBuilder: (context, index) {
                          return InscriptionCard(
                              inscriptions[index].wid,
                              inscriptions[index].userName,
                              inscriptions[index].userImage,
                              inscriptions[index].quantity,
                              inscriptions[index].eventWid,
                              inscriptions[index].eventDate,
                              inscriptions[index].extraData,
                              inscriptions[index].inscriptionFields,
                              inscriptions[index].participants);
                        }))
              ],
            ),
          );
  }

  void search(String s) {
    if (codesMap.containsKey(s)) {
      for (var inscription in inscriptions) {
        if (inscription.wid == codesMap[s]) {
          Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SpecificInscriptionScreen(
                        inscription.wid,
                        inscription.userName,
                        inscription.image,
                        inscription.quantity,
                        inscription.eventWid,
                        inscription.eventDate,
                        inscription.extraData,
                        inscription.inscriptionFields,
                        inscription.participants)));
        }
      }
    } else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("No existe ningún código con ese valor.")));
    }
  }

  Future scan() async {
    try {
      var result = await BarcodeScanner.scan();
      search(result.rawContent);
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
