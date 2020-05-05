import 'package:flutter/material.dart';
import 'package:pueblos_app/components/events/subscriptionCard.dart';
import 'package:pueblos_app/model/subscription.dart';

class SubscriptionsContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubscriptionsContainerState();
}

class _SubscriptionsContainerState extends State<SubscriptionsContainer> {
  String totalAsistants = "12";
  String inscriptionsNum = "5";
  var subscriptions = List<Subscription>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              //Searchbar y filtros
              children: <Widget>[
                Container(
                    child: Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () => print("Searched"),
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    )),
                Padding(padding: EdgeInsets.only(left: 10)),
                Container(
                  child: Icon(
                    Icons.center_focus_weak,
                    size: 32,
                  ),
                )
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            //Searchbar y filtros
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(0xFFDAE1F5),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          inscriptionsNum,
                          style: TextStyle(
                              color: Color(0xFF4E67AA),
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Container(
                        child: Text(
                          "Inscripciones",
                          style: TextStyle(color: Color(0xFF4E67AA)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(0xFFDAE1F5),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          totalAsistants,
                          style: TextStyle(
                              color: Color(0xFF4E67AA),
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Container(
                        child: Text(
                          "Asistentes totales",
                          style: TextStyle(color: Color(0xFF4E67AA)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          SubscriptionCard()
        ],
      ),
    );
  }
  Widget suscriptionList(){
    return Container(
          padding: EdgeInsets.only(top:10),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SubscriptionCard(),
                )
              ],
            ),
          );
  }

  
}
