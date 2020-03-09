
import 'package:flutter/material.dart';

import 'newsElement.dart';

class ImageNewsCard extends StatefulWidget {
  String id;
  String image;
  String title;
  String description;
  String publishDate;

  ImageNewsCard(String id, String image, String title, String description, String publishDate) {
    this.id = id;
    this.image = image;
    this.title = title;
    this.description = description;
    this.publishDate = publishDate;
  }

  @override
  State<StatefulWidget> createState() => _ImageNewsCardState();
}

class _ImageNewsCardState extends State<ImageNewsCard> {
  @override
  Widget build(BuildContext context) {
    String id = widget.id;
    String image = widget.image;
    String title = widget.title;
    String description = widget.description;
    String publishDate = widget.publishDate;

    if (image == null) {
      image =
          "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80";
    }

    return GestureDetector(
      onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return DetailedNewsItem(id, title, image, description, publishDate);
            }));
          },
      child: Container(
        child: SizedBox(
          width: 800,
          height: 200,
          child: Container(
            child: Card(
              elevation: 2,
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                  Container(
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
                        Text(
                          title,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ),
    );
  }
}