import 'package:flutter/material.dart';
import 'package:pueblos_app/authService.dart';
import 'package:pueblos_app/components/events/eventsContainer.dart';
import 'package:pueblos_app/components/news/newsContainer.dart';
import 'package:pueblos_app/components/proclamations/proclamationsContainer.dart';
import 'package:pueblos_app/screens/addProclamationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pueblos_icons.dart';
import 'configEventsScreen.dart';
import 'configNewsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _user = "";
  String _email = "";
  String _activeVillageName = "";
  String _activeVillageId = "";

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  //Carga el usuario que ha iniciado sesion
  _loadUser() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      _user = (userPrefs.getString('user') ?? 'Sesión no iniciada');
      _email = (userPrefs.getString('email') ?? 'No email');

      _activeVillageName = userPrefs.getString('activeName');
    });
  }

  //Las opciones del BottomNavBar
  List<Widget> _widgetOptions = <Widget>[
    ProclamationsContainer(), //Container con la lista de bandos
    NewsContainer(), //Container con la lista de noticias
    EventsContainer() //Container con la lista de eventos
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Boton flotante para añadir un nuevo bando
    var addButton = FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddProclamationScreen()));
      },
      child: Icon(Icons.add),
      backgroundColor: Color(0xFF29BF79),
    );
    var configNewsButton = FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => configNewsScreen()));
      },
      child: Icon(Icons.settings),
      backgroundColor: Color(0xFF29BF79),
    );
    var configEventsButton = FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => configEventsScreen()));
      },
      child: Icon(Icons.settings),
      backgroundColor: Color(0xFF29BF79),
    );

    //Construccion de la pantalla
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.verified_user), //Icono del pueblo
        title: Text(_activeVillageName), //Nombre del pueblo
        actions: <Widget>[
          GestureDetector(
            onTap: () => _settingModalBottomSheet(context),
            child: CircleAvatar(
              radius: 24,
              child: ClipOval(
                  child: Image.network(
                      "https://eu.ui-avatars.com/api/?name=" + _user)),
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 20))
        ],
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      floatingActionButton: _selectedIndex == 0 ? addButton : (_selectedIndex == 1 ? configNewsButton: configEventsButton),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Pueblos.bullhorn), title: Text('Bandos')),
          BottomNavigationBarItem(
              icon: Icon(Pueblos.newspaper), title: Text('Noticias')),
          BottomNavigationBarItem(
              icon: Icon(Pueblos.calendar_full), title: Text('Eventos')),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
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
                    CircleAvatar(
                      radius: 24,
                      child: ClipOval(
                          child: Image.network(
                              "https://eu.ui-avatars.com/api/?name=" + _user)),
                    ),
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
                                    _user,
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(_email,
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
                  leading: Icon(Icons.event_note),
                  title: Text("Mis eventos"),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(Pueblos.ticket),
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
                  onTap: () => {
                    _user = "",
                    _email = "",
                    AuthService().logout(),
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/LoginScreen', (Route<dynamic> route) => false)
                  },
                )
              ],
            )
          ]));
        });
  }
}
