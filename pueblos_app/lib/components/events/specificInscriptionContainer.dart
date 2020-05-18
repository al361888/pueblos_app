import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class SpecificInscriptionContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpecificInscriptionContainerState();
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
    this.isConfirmed = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
  bool isConfirmed;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    int index1 = index + 1;
    return Item(
      headerValue: 'Asistente $index1',
      expandedValue: 'This is item number $index1',
    );
  });
}

class _SpecificInscriptionContainerState
    extends State<SpecificInscriptionContainer> {
  String inscriptionAsistants = '5';
  List<Item> _data = generateItems(4);
  ScanResult _barcode;

  @override
  Widget build(BuildContext context) {
    _barcode!=null?print(_barcode.rawContent):print("No hay codigo");
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
                    fit: BoxFit.fill,
                    image:
                        new NetworkImage("https://i.imgur.com/BoN9kdC.png")))),
        Padding(padding: EdgeInsets.only(left: 20)),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "Carl Johnson",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  child: Text(
                    "Carl Johnson",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  child: Text(
                    "21 de enero 2020",
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xFF1E2C41)),
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
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E2C41)),
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
                      child: Text(item.expandedValue,
                          style: TextStyle(fontSize: 16))),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
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
                        }),
                  ),
                ],
              ),
            ),
            isExpanded: item.isExpanded,
          );
        }).toList(),
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
