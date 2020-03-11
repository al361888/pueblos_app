import 'package:flutter/material.dart';
import 'package:pueblos_app/components/proclamations/proclamationCard.dart';

class ProclamationsContainer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ProclamationContainer();
}
  
class _ProclamationContainer extends State<ProclamationsContainer>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[ProclamationCard(),
          ProclamationCard(),
          ProclamationCard(),
        ],
      ),
    );
  }
}