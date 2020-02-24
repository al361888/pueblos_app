import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
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
