import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pueblos_app/authService.dart';
import 'package:pueblos_app/components/events/eventsContainer.dart';
import 'package:pueblos_app/components/news/newsContainer.dart';
import 'package:pueblos_app/components/proclamations/proclamationsContainer.dart';
import 'package:pueblos_app/model/user.dart';
import 'package:pueblos_app/screens/addProclamationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pueblos_icons.dart';
import 'events/configEventsScreen.dart';
import 'inscriptions/myInscriptionsScreen.dart';
import 'news/configNewsScreen.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _selectedIndex = 1;
  String _user = "";
  String _email = "";
  String _activeVillageName = "";
  bool notificationSwitch = false;
  bool isVillageAdmin = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _isVillageAdmin();
  }

  //Carga el usuario que ha iniciado sesion
  _loadUser() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      _user = (userPrefs.getString('userName') ?? 'Sesión no iniciada');
      _email = (userPrefs.getString('email') ?? 'No email');

      _activeVillageName = userPrefs.getString('activeVillageName');
    });
    AuthService().refreshToken();
  }

  _isVillageAdmin() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    Map<String, dynamic> managedVillages =
        jsonDecode(userPrefs.getString('managedVillages'));
    managedVillages.forEach((k, v) {
      if ('$k' == userPrefs.getString('activeVillageId')) {
        if (managedVillages['$k']['isAdmin'] == '1' || managedVillages['$k']['communities'][0]!=null) {
          setState(() {
            isVillageAdmin = true;
          });
        }
      }
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
    String avatarImageUrl = "https://eu.ui-avatars.com/api/?name=" + _user;

    //Construccion de la pantalla
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.verified_user),
            onPressed: () => showModalBottomSheet(
                context: context,
                builder: (BuildContext bc) {
                  return SettingVillageModalBottom(
                    switchValue: notificationSwitch,
                    valueChanged: (value) {
                      notificationSwitch = value;
                    },
                  );
                })), //Icono del pueblo
        title: Text(_activeVillageName), //Nombre del pueblo
        actions: <Widget>[
          GestureDetector(
            onTap: () => _settingModalBottomSheet(context),
            child: CircleAvatar(
              radius: 24,
              child: ClipOval(child: Image.network(avatarImageUrl)),
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 20))
        ],
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      floatingActionButton: getFAB(_selectedIndex),
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

  //Construcción de los floating action buttons
  Widget getFAB(int i) {
    if (isVillageAdmin == false) {
      return Container();
    } else {
      if (i == 0) {
        return FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddProclamationScreen()));
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF29BF79),
        );
      } else if (i == 1) {
        return FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ConfigNewsScreen()));
          },
          child: Icon(Icons.settings),
          backgroundColor: Color(0xFF29BF79),
        );
      } else if (i == 2) {
        return FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ConfigEventsScreen()));
          },
          child: Icon(Icons.settings),
          backgroundColor: Color(0xFF29BF79),
        );
      }
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
                  leading: Icon(Pueblos.ticket),
                  title: Text("Mis Inscripciones"),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyInscriptionsScreen()))
                  },
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

class SettingVillageModalBottom extends StatefulWidget {
  SettingVillageModalBottom(
      {@required this.switchValue, @required this.valueChanged});

  final bool switchValue;
  final ValueChanged valueChanged;

  @override
  State<StatefulWidget> createState() => _SettingVillageModalBottom();
}

class _SettingVillageModalBottom extends State<SettingVillageModalBottom> {
  bool _switchValue;

  @override
  initState() {
    super.initState();
    _switchValue = widget.switchValue;
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Icon(Icons.landscape),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                    "Nombre del pueblo",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.grey),
                  ),
                ],
              )),
          Divider(thickness: 1),
          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
              padding: EdgeInsets.only(left: 20),
              child: Text("Recibir notificaciones",
                  style: TextStyle(fontWeight: FontWeight.w500))),
          Container(
            child: Switch(
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                  print(_switchValue);
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
