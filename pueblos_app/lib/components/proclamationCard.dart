import 'package:flutter/material.dart';

class ProclamationCard extends StatelessWidget {
  var horaSalida = DateTime(2020, 2, 26, 9, 0, 0, 0, 0);
  @override
  Widget build(BuildContext context) {
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
                    Text("Ha venido el afilador", textAlign: TextAlign.center,),
                  ]),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                          'Et et accumsan eu congue. Amet amet neque ut imperdiet amet nec porta tellus id. Varius et viverra senectus id imperdiet urna id vitae maecenas. Morbi porttitor volutpat tincidunt mauris duis mauris id faucibus quis. Id id vitae sit et sed eu id. At egestas.',
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Cerrar'),
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top:15, left:15, right: 15),
                    child: Image.asset("assets/images/escudo.png",
                        width: 40, height: 40),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(top:20, right: 20),
                    child: Text("El carnicero se ha cortado la mano con la chopetera.",
                        style: TextStyle(fontWeight: FontWeight.w500,
                        fontSize: 18)),
                  ),)
                ]),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  child: Chip(
                      //Fecha de salida
                      padding: EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: Colors.white,
                      label: Text("Hace " +
                          DateTime.now()
                              .difference(horaSalida)
                              .inMinutes
                              .toString() +
                          " min", style: TextStyle(fontStyle: FontStyle.italic),),
                    ),
                )
              ]),
        ),
      ),
    );
  }
}
