import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detailedNewsItem.dart';

class NewsElement extends StatefulWidget {
  String id;
  String image;
  String title;
  String description;
  String publishDate;
  String domain;

  NewsElement(String id, String image, String name, String description,
      String publishDate, String domain) {
    this.id = id;
    this.image = image;
    this.title = name;
    this.description = description;
    this.publishDate = publishDate;
    this.domain = domain;
  }

  @override
  State<StatefulWidget> createState() => _NewsElementState();
}

class _NewsElementState extends State<NewsElement> {

  @override
  Widget build(BuildContext context) {
    String domain = widget.domain;
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
      image = domain+ "/apps/files/file/" + image;
    }

    return Hero(
      tag: 'news$id',
      child: Material(
        child: InkWell(
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

