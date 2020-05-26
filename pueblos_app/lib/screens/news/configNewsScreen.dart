import 'package:flutter/material.dart';
import 'package:pueblos_app/components/news/editableNewsContainer.dart';

import '../../authService.dart';
import 'addNewsScreen.dart';

class ConfigNewsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConfigNewsScreenState();
}

class _ConfigNewsScreenState extends State<ConfigNewsScreen> {

  @override
  void initState() {
    super.initState();
    AuthService().refreshToken();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Abandonar edición",
            //style: TextStyle(color: Colors.white),
          )),
          floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddNewsScreen()));
      },
      child: Icon(Icons.add),
      backgroundColor: Color(0xFF29BF79),
    ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: EditableNewsContainer(),
      ),
    );
  }
}
