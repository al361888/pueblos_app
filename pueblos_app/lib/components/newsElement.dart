import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsElement extends StatefulWidget {
  String id;
  String image;
  String title;
  String description;
  String publishDate;

  NewsElement(String id, String image, String name, String description,
      String publishDate) {
    this.id = id;
    this.image = image;
    this.title = name;
    this.description = description;
    this.publishDate = publishDate;
  }

  @override
  State<StatefulWidget> createState() => _NewsElementState();
}

class _NewsElementState extends State<NewsElement> {
  @override
  Widget build(BuildContext context) {
    String id = widget.id;
    String image = widget.image;
    String title = widget.title;
    String description = widget.description;
    String publishDate = widget.publishDate;

    String tiempoNoticia = calculateTimeDiff(publishDate);

    if (image == null) {
      image =
          "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80";
    } else {
      image = "https://mas.villanuevadeviver.es/apps/files/file/" + image;
    }

    return Hero(
      tag: 'news$id',
      child: Material(
        child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailedNewsItem(
                    id, title, image, description, publishDate);
              }));
            },
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              child: Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image: image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )),
                          Container(
                              decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.1, 0.8],
                              colors: [Color(0xCC272741), Color(0x00272741)],
                            ),
                          )),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                child: Text(title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Padding(padding: EdgeInsets.only(top: 9)),
                              Container(
                                child: Text(
                                  tiempoNoticia,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  )),
            )),
      ),
    );
  }
}

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
                      placeholder: 'assets/images/landscape.jpg',
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
