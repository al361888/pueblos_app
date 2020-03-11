import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EventCard extends StatefulWidget {
  String id;
  String image;
  String name;
  String description;
  String active;
  String eventDate;
  String registrationInitDate;
  String registrationFinishDate;
  String price;
  String domain;

  EventCard(
      String id,
      String image,
      String name,
      String description,
      String eventDate,
      String registrationInitDate,
      String registrationFinishDate,
      String price,
      String domain) {
    this.id = id;
    this.image = image;
    this.name = name;
    this.description = description;
    this.eventDate = eventDate;
    this.registrationInitDate = registrationInitDate;
    this.registrationFinishDate = registrationFinishDate;
    this.price = price;
    this.domain=domain;
  }

  @override
  State<StatefulWidget> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    String id = widget.id;
    String image = widget.domain + "/apps/files/file/" + widget.image;
    String name = widget.name;
    String description = widget.description;
    String eventDate = widget.eventDate;
    String registrationInitDate = widget.registrationInitDate;
    String registrationFinishDate = widget.registrationFinishDate;
    String price = widget.price;

    var aux = DateTime.parse(eventDate);
    String day = aux.day.toString();
    String month = aux.month.toString();
    if (aux.day < 10) {
      day = "0" + day;
    }
    if (aux.month < 10) {
      month = "0" + month;
    }
    eventDate = day + "/" + month + "/" + aux.year.toString();

    return Material(
      child: GestureDetector(
          onTap: () {},
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4,
              child: Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: image,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 15)),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 15)),
                        Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                              size: 20,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Text(
                              eventDate,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.language,
                              color: Colors.grey,
                              size: 20,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Text(
                              "Comunidad",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 15)),
                        Text(price + "€",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        Padding(padding: EdgeInsets.only(bottom: 15))
                      ],
                    ),
                  )
                ],
              )))),
    );
  }
}
