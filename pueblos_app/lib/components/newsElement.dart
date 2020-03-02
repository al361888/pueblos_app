import 'package:flutter/material.dart';
import 'package:pueblos_app/components/proclamationCard.dart';

class NewsElement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsElementState();
}

class _NewsElementState extends State<NewsElement> {
  String tiempoNoticia = calculateTimeDiff();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'news',
      child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return DetailedNewsItem();
            }));
          },
          child: Container(
              padding: EdgeInsets.all(15),
              color: Colors.yellow,
              child: Row(
                children: <Widget>[
                  Image.asset("assets/images/landscape.jpg",
                      width: 100, height: 100),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        "Hemos ido a este pueblo y no te creerás lo que pasa al final. ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                        textAlign: TextAlign.justify,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: Chip(
                          //Fecha de salida
                          padding: EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: Colors.white,
                          label: Text(
                            tiempoNoticia,
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}

class DetailedNewsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            child: Center(
                child: Hero(
                    tag: "news",
                    child: Image.asset("assets/images/landscape.jpg"))),
            onTap: () {
          Navigator.pop(context);
        }));
  }
}
