import 'package:flutter/material.dart';
import 'package:pueblos_app/components/news/editableNewsContainer.dart';
import 'package:pueblos_app/components/news/newsContainer.dart';
import 'package:pueblos_app/components/news/newsElement.dart';

import 'addNewsScreen.dart';

class configNewsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _configNewsScreenState();
}

class _configNewsScreenState extends State<configNewsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Abandonar edición",
            //style: TextStyle(color: Colors.white),
          )),
          floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddNewsScreen()));
      },
      child: Icon(Icons.add),
      backgroundColor: Color(0xFF29BF79),
    ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: EditableNewsContainer(),
      ),
    );
  }
}
