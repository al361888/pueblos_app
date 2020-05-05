import 'package:flutter/material.dart';
import 'package:pueblos_app/components/events/editableEventsContainer.dart';
import 'package:pueblos_app/components/events/eventsContainer.dart';

class configEventsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _configEventsScreenState();
}

class _configEventsScreenState extends State<configEventsScreen> {
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
      body: Container(
        padding: EdgeInsets.all(20),
        child: EditableEventsContainer(),
      ),
    );
  }
}
