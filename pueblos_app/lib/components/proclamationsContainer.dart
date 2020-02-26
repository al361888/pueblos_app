import 'package:flutter/material.dart';
import 'package:pueblos_app/components/proclamationCard.dart';

class proclamationsContainer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _proclamationContainer();
}
  
class _proclamationContainer extends State<proclamationsContainer>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ProclamationCard(),
    );
  }
}