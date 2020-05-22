import 'package:flutter/material.dart';

class DetailedInscription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DetailedInscriptionState();
}

class _DetailedInscriptionState extends State<DetailedInscription> {
  String name = "Ruta por el sendero nevado";
  String eventDate = "21 de enero 2020";
  String eventTime = "20:30";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 125,
              width: 500,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1501785888041-af3ef285b470?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              eventDate,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.grey),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              eventTime,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.grey),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Expanded(
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return CodeCard();
              }
              ),
            )
          ],
        ),
      )),
    );
  }
}

class CodeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png",
            width: 350,
            height: 300,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Nombre: ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        height: 1.5)),
                Text("Es alergico: ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        height: 1.5)),
                Text("Menu: ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        height: 1.5)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
