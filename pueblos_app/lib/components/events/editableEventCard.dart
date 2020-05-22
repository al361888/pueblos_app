import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pueblos_app/screens/events/editEventScreen.dart';
import 'package:pueblos_app/screens/eventInscriptionsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiCalls.dart';
import 'detailedEvent.dart';

class EditableEventCard extends StatefulWidget {
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

  EditableEventCard(
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
    this.domain = domain;
  }

  @override
  State<StatefulWidget> createState() => _EditableEventCardState();
}

class _EditableEventCardState extends State<EditableEventCard> {
  String activeVillageWid;
  String token;

   @override
  initState() {
    super.initState();
    _getVillageId();
  }

  _getVillageId() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      activeVillageWid = userPrefs.getString('activeVillageId');
      token = userPrefs.getString('token');
    });
  }
  
  @override
  Widget build(BuildContext context) {
    String id = widget.id;
    String image = widget.domain + "/files/" + widget.image;
    String name = widget.name;
    String description = widget.description;
    String eventDate = _getProperDateFormat(widget.eventDate);
    String registrationInitDate = widget.registrationInitDate;
    String registrationFinishDate = widget.registrationFinishDate;
    String price = widget.price;

    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailedEvent(id, image, name, description, eventDate,
                registrationInitDate, registrationFinishDate, price);
          }));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: image,
                      height: 220,
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(padding: EdgeInsets.only(left: 15)),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 15)),
                    Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Padding(padding: EdgeInsets.only(top: 15)),
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
              ),
              Expanded(
                      child: PopupMenuButton<int>(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                                children: <Widget>[
                                  Icon(Icons.confirmation_number, color: Colors.grey),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("Ver Inscripciones", style: TextStyle(color:Color(0xFF1E2C41))),
                                ],
                              ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Row(
                                children: <Widget>[
                                  Icon(Icons.visibility_off, color: Colors.grey),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("Ocultar evento", style: TextStyle(color:Color(0xFF1E2C41))),
                                ],
                              ),
                          ),
                          PopupMenuItem(
                            value: 3,
                            child: Row(
                                children: <Widget>[
                                  Icon(Icons.edit, color: Colors.grey),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("Editar evento", style: TextStyle(color:Color(0xFF1E2C41))),
                                ],
                              ),
                          ),
                          PopupMenuItem(
                            value: 4,
                            child: Row(
                                children: <Widget>[
                                  Icon(Icons.delete, color: Colors.grey),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("Eliminar evento", style: TextStyle(color:Color(0xFF1E2C41))),
                                ],
                              ),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 1) {
                            Navigator.push(context,
            MaterialPageRoute(builder: (context) => EventInscriptionsScreen()));
                          } else if (value == 2) {
                            bool success = _hideEvent(activeVillageWid, widget.id, widget.active, token);
                              print(success);
                              if(success){
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Noticia ocultada correctamente")));
                                Navigator.pop(context);
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Error al ocultar la noticia")));
                              }
                          } else if (value == 3) {
                            Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditEventScreen(id)));
                          } else if (value == 4) {
                            print("Eliminar evento");
                          }
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
  bool _hideEvent(String activeVillageWid, String id, String active, String token){
    bool res = false;
    ApiCalls().hideEvent(activeVillageWid, widget.id, widget.active, token).then((result) {
      print("RESULT???? "+ (result?"true":"false"));
      return result;
    });
    return res;
  }
}

String _getProperDateFormat(String old) {
  var aux = DateTime.parse(old);
  String day = aux.day.toString();
  String month = aux.month.toString();
  if (aux.day < 10) {
    day = "0" + day;
  }
  if (aux.month < 10) {
    month = "0" + month;
  }
  return day + "/" + month + "/" + aux.year.toString();
}
