import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailedNewsItem extends StatelessWidget {
  String title;
  String id;
  String image;
  String description;
  String publishDate;

  DetailedNewsItem(String id, String name, String image, String description,
      String publishDate) {
    this.id = id;
    this.image = image;
    this.title = name;
    this.description = description;

    var aux = DateTime.parse(publishDate);
    String day = aux.day.toString();
    String month = aux.month.toString();
    if (aux.day < 10) {
      day = "0" + day;
    }
    if (aux.month < 10) {
      month = "0" + month;
    }
    this.publishDate = day +
        "/" +
        month +
        "/" +
        aux.year.toString() +
        " " +
        aux.hour.toString() +
        ":" +
        aux.minute.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
        elevation: 0,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Stack(
            //fit: StackFit.expand,
            children: <Widget>[
              Hero(
                  tag: 'news$id',
                  child: FadeInImage.assetNetwork(
                      placeholder: image,
                      image: image)),
              Positioned(
                bottom: 0,
                width: 800,
                height: 150,
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.1, 0.8],
                      colors: [Color(0xCC272741), Color(0x00272741)],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 400,
                        child: Text(
                          title,
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text(publishDate,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(child: Html(data: description)),
            ),
          ),
        ],
      )),
    );
  }
}

String calculateTimeDiff(String date) {
  var dateArg = DateTime.parse(date); //Coger de la bbdd
  Duration diff = DateTime.now().difference(dateArg);
  if (diff.inDays == 1) {
    return "Hace " + diff.inDays.toString() + " día";
  } else if (diff.inDays > 1) {
    return "Hace " + diff.inDays.toString() + " días";
  } else if (diff.inHours == 1) {
    return "Hace " + diff.inHours.toString() + " hora";
  } else if (diff.inHours > 1) {
    return "Hace " + diff.inHours.toString() + " horas";
  } else {
    return "Hace " + diff.inMinutes.toString() + " minutos";
  }
}
