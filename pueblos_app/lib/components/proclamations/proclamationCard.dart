import 'package:flutter/material.dart';

class ProclamationCard extends StatefulWidget {
  String title;
  String description;
  String community;
  String date;

  ProclamationCard(
      String title, String description, String community, String date) {
    this.title = title;
    this.description = description;
    this.community = community;
    this.date = date;
  }
  @override
  _ProclamationCardState createState() => _ProclamationCardState();
}

class _ProclamationCardState extends State<ProclamationCard> {
  String tiempoTarjeta = calculateTimeDiff();

  Image escudoComunidad;

  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    String description = widget.description;

    return Container(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            //Al pulsar la carta del bando, se abre un dialogo con toda la informacion
            return showDialog<void>(
              context: context,
              barrierDismissible:
                  true, //Permite que se pueda cerrar tocando la pantalla
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Column(children: <Widget>[
                    Image.asset("assets/images/escudo.png",
                        width: 60, height: 60),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                    ),
                  ]),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                          description,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Cerrar', style: TextStyle(color: Theme.of(context).primaryColor),),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Column(
              //Aqui empieza el codigo de apariencia de la carta
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Image.asset("assets/images/escudo.png",
                        width: 40, height: 40),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(top: 20, right: 20),
                      child: Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                    ),
                  )
                ]),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  child: Chip(
                    //Fecha de salida
                    padding: EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: Colors.white,
                    label: Text(
                      tiempoTarjeta,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

String calculateTimeDiff() {
  var horaSalida = DateTime(2020, 2, 27, 10, 40, 0, 0, 0); //Coger de la bbdd
  Duration diff = DateTime.now().difference(horaSalida);
  if (diff.inDays == 1) {
    return "Hace " + diff.inDays.toString() + " día";
  } else if (diff.inDays > 1) {
    return "Hace " + diff.inDays.toString() + " días";
  } else if (diff.inHours == 1) {
    return "Hace " + diff.inHours.toString() + " hora";
  } else if (diff.inHours > 1) {
    return "Hace " + diff.inHours.toString() + " horas";
  } else {
    return "Hace " + diff.inMinutes.toString() + " minutos";
  }
}
