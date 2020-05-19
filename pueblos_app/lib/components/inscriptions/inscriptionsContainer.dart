import 'package:flutter/material.dart';
import 'package:pueblos_app/model/inscription.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

import 'inscriptionCard.dart';

class InscriptionsContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InscriptionsContainerState();
}

class _InscriptionsContainerState extends State<InscriptionsContainer> {
  final myController = TextEditingController();
  var inscriptions = List<Inscription>();
  ScanResult _barcode;
  String totalAsistants = "12";
  String inscriptionsNum = "5";
  // String inscriptionsNum = inscriptions.length;
  bool isLoading = true;

  _getAsistants() async {
    // SharedPreferences userPrefs = await SharedPreferences.getInstance();
    // _domain = userPrefs.getString('activeDomain');

    // ApiCalls(_domain).getAsistants().then((response) {
    //   if (response.statusCode == 200) {
    //     setState(() {
    //       Iterable list = json.decode(response.body)['data'];
    //       inscriptions = list.map((model) => Inscription.fromJson(model)).toList();
    //     });
    //     isLoading = false;
    //   } else {
    //     _getAsistants();
    //   }
    // });
  }

  @override
  void initState() {
    super.initState();
    _getAsistants();
  }

  @override
  Widget build(BuildContext context) {
    _barcode != null ? print(_barcode.rawContent) : print("No hay codigo");
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
                    controller: myController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: (){
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
          suscriptionList()
        ],
      ),
    );
  }

  Widget suscriptionList() {
    return Expanded(
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return InscriptionCard();
            }));
  }

  String search(String s){
    print(s);
    return s;
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
