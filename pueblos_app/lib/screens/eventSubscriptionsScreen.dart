import 'package:flutter/material.dart';
import 'package:pueblos_app/components/events/subscriptionsContainer.dart';

class EventSubscriptionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EventSubscriptionsScreenState();
}

class _EventSubscriptionsScreenState extends State<EventSubscriptionsScreen> {
  @override
  Widget build(BuildContext context) {
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
        child: SubscriptionsContainer(),
      ),
    );
  }
}

