import 'package:flutter/material.dart';

import 'myInscriptionCard.dart';

class MyInscriptionsContainer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyInscriptionsContainerState();
    }
  
  class _MyInscriptionsContainerState extends State<MyInscriptionsContainer>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index){
                return MyInscriptionCard();
              })),
        ],
      ),
    );
  }

}

