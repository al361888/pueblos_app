import 'package:flutter/material.dart';

class SubscriptionCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              new Container(
                  width: 55,
                  height: 55,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "https://i.imgur.com/BoN9kdC.png")))),
              Padding(padding: EdgeInsets.only(left: 20)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Carl Johnson",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Carl Johnson",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      child: Text(
                        "21 de enero 2020",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Chip(
                backgroundColor: Color(0xFFDAE1F5),
                label: Text('1', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4E67AA)),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
