import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pueblos_app/authService.dart';
import 'package:pueblos_app/components/events/eventsContainer.dart';
import 'package:pueblos_app/components/news/newsContainer.dart';
import 'package:pueblos_app/components/proclamations/proclamationsContainer.dart';
import 'package:pueblos_app/model/village.dart';
import 'package:pueblos_app/screens/addProclamationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apiCalls.dart';
import '../messageHandler.dart';
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
  String activeVillageImage;
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
      activeVillageImage = userPrefs.getString('activeVillageImage');
    });
    var subscribedVillages =
        jsonDecode(userPrefs.getString('subscribedVillages'));
    for (var s in subscribedVillages) {
      if (s['wid'] == _activeVillageName) {
        setState(() {
          notificationSwitch = true;
        });
      }
    }
    AuthService().refreshToken();
  }

  _isVillageAdmin() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    Map<String, dynamic> managedVillages =
        jsonDecode(userPrefs.getString('managedVillages'));
    managedVillages.forEach((k, v) {
      if ('$k' == userPrefs.getString('activeVillageId')) {
        if (managedVillages['$k']['isAdmin'] == '1' ||
            managedVillages['$k']['communities'][0] != null) {
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
  String activeVillageWid;
  String activeVillageName;
  String activeVillageImage;
  String activeVillageImageUrl;
  String token;

  @override
  initState() {
    super.initState();
    _switchValue = widget.switchValue;
    _getVillages();
  }

  dispose() {
    super.dispose();
  }

  _getVillages() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      activeVillageName = (userPrefs.getString('activeVillageName'));
      activeVillageImage = (userPrefs.getString('activeVillageImage'));
      activeVillageWid = userPrefs.getString('activeVillageId');
      token = userPrefs.getString('token');
      if (activeVillageImage != null) {
        activeVillageImageUrl =
            "http://vueltalpueblo.es/files/" + activeVillageImage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (activeVillageImageUrl == null) {
      activeVillageImage =
          "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80";
    }

    print(activeVillageImageUrl);
    //lA IMAGEN NO VA, DE MOMENTO CARGA UNA POR DEFECTO
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      color: Color(0xFF737373),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    Image.network(
                      activeVillageImageUrl,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text(
                      activeVillageName,
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
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Switch(
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                    _suscribeToVillage(_switchValue, activeVillageWid, token);
                  });
                },
                activeTrackColor: Color(0xFF0EB768),
                activeColor: Colors.white,
              ),
            ),
            ListTile(
                onTap: () {
                  _villageSelectorModalSheet(context);
                },
                title: Text("Cambiar de pueblo",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor))),
          ],
        ),
      ),
    );
  }

  Future<void> _suscribeToVillage(
      bool switchValue, String villageId, String token) async {
    if (switchValue) {
      await ApiCalls()
          .subscribeToVillage(villageId, token)
          .then((response) => print(response.body));
      MessageHandler messageHandler = MessageHandler();
      messageHandler.fcmSubscribe(villageId);

    } else {
      await ApiCalls()
          .unsubsbcribeToVillage(villageId, token)
          .then((response) => print(response.body));
      MessageHandler messageHandler = MessageHandler();
      messageHandler.fcmUnSubscribe(villageId);
    }
  }

  Future<void> _villageSelectorModalSheet(BuildContext context) async {
    final myController = TextEditingController();
    var villages = List<Village>();
    List<String> villageNames = [];
    List<Village> _searchResult = [];

    await ApiCalls().getVillages().then((response) {
      if (response.statusCode == 200) {
        setState(() {
          Iterable list = json.decode(response.body)['data'];
          villages = list.map((model) => Village.fromJson(model)).toList();
          for (Village village in villages) {
            villageNames.add(village.name);
          }
        });
      }
    });
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            color: Color(0xFF333333),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20))),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        hintText: "Buscar un pueblo...",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (text) {
                        _searchResult.clear();
                        if (text.isEmpty) {
                          setState(() {});
                          return;
                        }

                        villages.forEach((v) {
                          if (v.name.contains(text) || v.name.contains(text))
                            _searchResult.add(v);
                        });

                        setState(() {});
                      },
                    ),
                  ),
                  Divider(thickness: 1),
                  Expanded(
                      child: _searchResult.length != 0 ||
                              myController.text.isNotEmpty
                          ? ListView.builder(
                              itemCount: _searchResult.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    leading: Image.network(
                                      _searchResult[index].image != null
                                          ? _searchResult[index].image
                                          : "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(_searchResult[index].name),
                                    onTap: () async {
                                      final userPrefs =
                                          await SharedPreferences.getInstance();
                                      userPrefs.setString('activeVillageName',
                                          _searchResult[index].name);
                                      userPrefs.setString('activeVillageId',
                                          _searchResult[index].id);
                                      userPrefs.setString('activeVillageImage',
                                          _searchResult[index].image);
                                      userPrefs.setString('activeVillageUrl',
                                          _searchResult[index].nameUrl);
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          "/HomeScreen", (route) => false);
                                    });
                              })
                          : ListView.builder(
                              itemCount: villages.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    leading: Image.network(
                                      villages[index].image != null
                                          ? villages[index].image
                                          : "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(villageNames[index]),
                                    onTap: () async {
                                      final userPrefs =
                                          await SharedPreferences.getInstance();
                                      userPrefs.setString('activeVillageName',
                                          villages[index].name);
                                      userPrefs.setString('activeVillageId',
                                          villages[index].id);
                                      userPrefs.setString('activeVillageImage',
                                          villages[index].image);
                                      userPrefs.setString('activeVillageUrl',
                                          villages[index].nameUrl);
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          "/HomeScreen", (route) => false);
                                    });
                              }))
                ],
              ),
            ),
          );
        });
  }
}
