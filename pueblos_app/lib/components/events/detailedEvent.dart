import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pueblos_app/screens/inscriptions/addInscriptionScreen.dart';

class DetailedEvent extends StatelessWidget {
  String id;
  String image;
  String name;
  String description;
  String active;
  String eventDate;
  String registrationInitDate;
  String registrationFinishDate;
  String price;

  DetailedEvent(
      String id,
      String image,
      String name,
      String description,
      String eventDate,
      String registrationInitDate,
      String registrationFinishDate,
      String price) {
    this.id = id;
    this.image = image;
    this.name = name;
    this.description = description;
    this.eventDate = eventDate;
    this.registrationInitDate = _getProperFormattedDate(registrationInitDate);
    this.registrationFinishDate =
        _getProperFormattedDate(registrationFinishDate);
    this.price = price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: 380,
        height: 50,
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddInscriptionScreen(id)));
          },
          child: Container(
              child: Text(
            "INSCRIBIRME",
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Hero(
                tag: 'event$id',
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.elliptical(60, 60)),
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif', image: image),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Chip(
                          //Fecha de salida
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          backgroundColor: Colors.grey[300],
                          label: Text(
                            price + "€",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                            size: 24,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Text(
                            eventDate,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          )
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Divider(),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Inscripción abierta desde:")),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            registrationInitDate,
                            style: TextStyle(color: Colors.grey),
                          )),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Hasta:")),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            registrationFinishDate,
                            style: TextStyle(color: Colors.grey),
                          )),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Divider(),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Descripción")),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                        child: SingleChildScrollView(
                            child: Html(data: description)),
                      ),
                      Padding(padding: EdgeInsets.only(top: 80)),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

String _getProperFormattedDate(String old) {
  var aux = DateTime.parse(old);
  String day = aux.day.toString();
  String month = aux.month.toString();
  String hour = aux.hour.toString();
  String minutes = aux.minute.toString();

  if (aux.day < 10) {
    day = "0" + day;
  }
  if (aux.month < 10) {
    month = "0" + month;
  }
  if (aux.hour < 10) {
    hour = "0" + hour;
  }
  if (aux.minute < 10) {
    minutes = "0" + minutes;
  }

  return day +
      "/" +
      month +
      "/" +
      aux.year.toString() +
      " a las " +
      hour +
      ":" +
      minutes;
}
