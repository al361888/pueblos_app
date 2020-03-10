import 'package:flutter/material.dart';
import 'package:pueblos_app/authService.dart';
import 'package:pueblos_app/components/eventsContainer.dart';
import 'package:pueblos_app/components/newsContainer.dart';
import 'package:pueblos_app/components/proclamationsContainer.dart';
import 'package:pueblos_app/screens/addProclamationScreen.dart';
import 'package:pueblos_app/screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pueblos_icons.dart';

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
      _user = (userPrefs.getString('user') ?? 'Username');
      _email = (userPrefs.getString('email') ?? 'email@email.com');

      _activeVillageName = userPrefs.getString('activeName');

      print(_activeVillageName);
    });
  }

  //Las opciones del BottomNavBar
  final List<Widget> _widgetOptions = <Widget>[
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
      floatingActionButton: _selectedIndex == 0 ? addButton : null,
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
                  leading: Icon(Icons.portrait),
                  title: Text("Mi Perfil"),
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
                        '/', (Route<dynamic> route) => false)
                  },
                )
              ],
            )
          ]));
        });
  }
}
