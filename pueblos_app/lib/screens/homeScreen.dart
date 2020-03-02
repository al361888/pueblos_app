import 'package:flutter/material.dart';
import 'package:pueblos_app/components/newsContainer.dart';
import 'package:pueblos_app/components/proclamationsContainer.dart';
import 'package:pueblos_app/screens/addProclamationScreen.dart';
import 'package:pueblos_app/screens/loginScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    proclamationsContainer(), //Una clase nueva
    NewsContainer(), //Una clase nueva
    Text('Aquí van los eventos') //Una clase nueva
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var floatingActionButton2 = FloatingActionButton(
      onPressed: () {
        if (_selectedIndex == 0) {
          //Bandos
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddProclamationScreen()));
        } else if (_selectedIndex == 1) {
          //Noticias
        } else {
          //Eventos
        }
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.green,
    );
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.verified_user), //Icono del pueblo
        title: Text('Nombre del pueblo'), //Nombre del pueblo
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.face), //Foto de perfil del usuario
              onPressed: () {
                _settingModalBottomSheet(context);
              })
        ],
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      floatingActionButton: floatingActionButton2,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.queue_play_next), title: Text('Bandos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt), title: Text('Noticias')),
          BottomNavigationBarItem(
              icon: Icon(Icons.event), title: Text('Eventos')),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

//Construcción del modal que surge cuando tocamos la foto de perfil del usuario
void _settingModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
            child: Column(children: [
          Container(
              padding: EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.face), //Foto de perfil
                  Padding(
                      padding: EdgeInsets.all(
                          18.0), //Espacio entre la imagen y el nombre de usuario
                      child: Row(
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Username",
                                  textAlign: TextAlign.left,
                                ),
                                Text("(Correo@gmail.com)",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic))
                              ])
                        ],
                      ))
                ],
              ),
              alignment: Alignment.centerLeft),
          Divider(thickness: 1),
          Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.portrait),
                title: Text("Mi Perfil"),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(Icons.monetization_on),
                title: Text("Mis Inscripciones"),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(Icons.inbox),
                title: Text("Mis Facturas"),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(Icons.close),
                title: Text("Cerrar sesión"),
                onTap: () => {},
              )
            ],
          )
        ]));
      });
}
