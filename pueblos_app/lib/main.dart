import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppPueblos',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Home'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//Home page compuesta de una bottomNavBar en con tres tabs: bandos, noticias y pueblos
class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Text('Aquí van los bandos'), //Una clase nueva
    Text('Aquí van las noticias'), //Una clase nueva
    Text('Aquí van los eventos') //Una clase nueva
  ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.verified_user), //Icono del pueblo
        title: Text('Nombre del pueblo'), //Nombre del pueblo
        actions: <Widget>[Icon(Icons.face)], //Foto de perfil del usuario
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.queue_play_next),
            title: Text('Bandos')
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            title: Text('Noticias')
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text('Eventos')
            ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        ),
    );
  }
}