import 'package:flutter/material.dart';
import 'package:pueblos_app/components/events/editableEventsContainer.dart';
import 'package:pueblos_app/components/events/eventsContainer.dart';

import 'addEventScreen.dart';

class ConfigEventsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConfigEventsScreenState();
}

class _ConfigEventsScreenState extends State<ConfigEventsScreen> {
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
            MaterialPageRoute(builder: (context) => AddEventScreen()));
      },
      child: Icon(Icons.add),
      backgroundColor: Color(0xFF29BF79),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: EditableEventsContainer(),
      ),
    );
  }
}
