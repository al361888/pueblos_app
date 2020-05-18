import 'package:flutter/material.dart';
import 'package:pueblos_app/components/events/inscriptionCard.dart';
import 'package:pueblos_app/model/inscription.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class InscriptionsContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InscriptionsContainerState();
}

class _InscriptionsContainerState extends State<InscriptionsContainer> {
  String totalAsistants = "12";
  String inscriptionsNum = "5";
  var subscriptions = List<Inscription>();
  ScanResult _barcode;

  @override
  Widget build(BuildContext context) {
    _barcode!=null?print(_barcode.rawContent):print("No hay codigo");
    return Container(
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
                          totalAsistants,
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
          InscriptionCard()
        ],
      ),
    );
  }

  Widget suscriptionList() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Expanded(
            child: InscriptionCard(),
          )
        ],
      ),
    );
  }

  Future scan() async {
    try {

      var result = await BarcodeScanner.scan();

      setState(() => this._barcode = result);
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
      setState(() {
        this._barcode = result;
      });
    }
  }
}
