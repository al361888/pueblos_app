import 'package:flutter/material.dart';
import "package:pueblos_app/components/newsElement.dart";

class NewsContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 10)),
          Expanded(
            child: ListView(
              children: <Widget>[
              NewsElement(0),
            NewsElement(1),
            NewsElement(2),
            NewsElement(3),
            NewsElement(4),
            NewsElement(5),
            NewsElement(6),
            NewsElement(7)
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
