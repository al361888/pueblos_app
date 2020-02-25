import 'package:flutter/material.dart';

class ProclamationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 150,
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
                    Text("Ha venido el afilador"),
                  ]),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                          'Et et accumsan eu congue. Amet amet neque ut imperdiet amet nec porta tellus id. Varius et viverra senectus id imperdiet urna id vitae maecenas. Morbi porttitor volutpat tincidunt mauris duis mauris id faucibus quis. Id id vitae sit et sed eu id. At egestas.',
                          textAlign: TextAlign.left,
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

                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Image.asset("assets/images/escudo.png",
                        width: 50, height: 50),
                    ),
                    Container(
                      child: Text("El titulo del bando.")
                      ,
                    )
                  ]
                ),
              ]),
        ),
      ),
    );
  }
}
