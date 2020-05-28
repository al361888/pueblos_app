import 'package:flutter/material.dart';
import 'package:pueblos_app/authService.dart';
import 'package:pueblos_app/components/inscriptions/inscriptionsContainer.dart';



class EventInscriptionsScreen extends StatefulWidget {
  String eventWid;

  EventInscriptionsScreen(String eventWid){
    this.eventWid = eventWid;
  }

  @override
  State<StatefulWidget> createState() => _EventInscriptionsScreenState();
}

class _EventInscriptionsScreenState extends State<EventInscriptionsScreen> {

  @override
  initState() {
    super.initState();
    AuthService().refreshToken();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Container(
        padding: EdgeInsets.all(20),
        child: InscriptionsContainer(widget.eventWid),
      ),
    );
  }
}
