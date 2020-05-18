import 'package:flutter/material.dart';
import 'package:pueblos_app/screens/specificInscriptionScreen.dart';

class InscriptionCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InscriptionCardState();
}

class _InscriptionCardState extends State<InscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 3,
        child: InkWell(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Container(
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
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
                  label: Text(
                    '1',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF4E67AA)),
                  ),
                )
              ],
            ),
          ),
          onTap: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => SpecificInscriptionScreen()));
          },
        ),
      ),
    );
  }
}
