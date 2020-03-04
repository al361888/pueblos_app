import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pueblos_app/components/proclamationCard.dart';

class NewsElement extends StatefulWidget {
  int id;

  NewsElement(int i) {
    this.id = i;
  }

  @override
  State<StatefulWidget> createState() => _NewsElementState();
}

class _NewsElementState extends State<NewsElement> {
  String tiempoNoticia = calculateTimeDiff();

  @override
  Widget build(BuildContext context) {
    int id = widget.id;

    return Hero(
      tag: 'news$id',
      child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return DetailedNewsItem(id);
            }));
          },
          child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: <Widget>[
                  Image.asset("assets/images/landscape.jpg",
                      width: 150, height: 125),
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: Text(
                              "El increíble suceso que no te esperas pero que pasó (o almenos eso creemos pero no nos hemos informado bastante, esto es simplemente un clickbait)",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                              maxLines: 3,
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Container(
                          child: Chip(
                            //Fecha de salida
                            backgroundColor: Colors.grey[300],
                            label: Text(
                              tiempoNoticia,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        )
                      ]),
                ],
              ))),
    );
  }
}

class DetailedNewsItem extends StatelessWidget {
  String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc volutpat arcu luctus augue hendrerit consequat. Aliquam non faucibus neque. Vestibulum condimentum nibh vel elit pellentesque, sit amet elementum ante semper. Quisque tristique turpis ac nulla lobortis, in cursus tellus porttitor. \n\nDuis sagittis tortor ex, a ullamcorper nunc imperdiet vitae. Maecenas facilisis efficitur faucibus. Nunc sit amet risus venenatis, placerat est facilisis, porta augue. Ut nec ligula at dui volutpat porttitor et vel mi. Sed nulla justo, interdum rutrum enim sed, tristique scelerisque sem. Quisque lacus augue, volutpat non pulvinar id, faucibus ac erat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin ultricies fringilla faucibus.\n\n Pellentesque non vestibulum lorem. Integer sollicitudin dolor ac ultrices congue. Vivamus elementum gravida diam a interdum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. ";
  String title =
      "El increíble suceso que no te esperas pero que pasó (o almenos eso creemos pero no nos hemos informado bastante, esto es simplemente un clickbait)";

  int id;

  DetailedNewsItem(int id) {
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.8),
        title: Text("Volver a noticias"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                  tag: 'news$id',
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset("assets/images/landscape.jpg"))),
              Positioned(
                top: 100,
                left: 10,
                height: 120,
                width: 400,
                child: Container(
                  //color: Colors.purple[100],
                  child: SelectableText(title,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: SingleChildScrollView(child: Html(data: loremIpsum * 4)),
            ),
          ),
        ],
      )),
    );
  }
}

/* Scaffold(backgroundColor: Colors.transparent,
                  appBar: AppBar(backgroundColor: Colors.transparent),
                  body: Container(
                    color: Colors.transparent,
                  ),
                  extendBodyBehindAppBar: true,
                  extendBody: true,
                ) */
