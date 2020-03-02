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
          NewsElement()
        ],
      ),
    );
  }
}
