import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pueblos_app/apiCalls.dart';
import 'package:pueblos_app/authService.dart';
import 'package:pueblos_app/model/inscription.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'myInscriptionCard.dart';

class MyInscriptionsContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyInscriptionsContainerState();
}

class _MyInscriptionsContainerState extends State<MyInscriptionsContainer> {
  var myInscriptions = List<Inscription>();
  String token;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getMyInscriptions();
    AuthService().refreshToken();
  }

  Future<void> _getMyInscriptions() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    token = userPrefs.getString('token');

    if (token != null) {
      ApiCalls().getMyInscriptions(token).then((response) {
        print(response.body);
        if (response.statusCode == 200) {
          setState(() {
            Iterable list = json.decode(response.body)['data'];
            myInscriptions =
                list.map((model) => Inscription.fromJson(model)).toList();
          });
          isLoading = false;
        } else {
          _getMyInscriptions();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: ListView.builder(
                        itemCount: myInscriptions.length,
                        itemBuilder: (context, index) {
                          return MyInscriptionCard(
                            myInscriptions[index].wid,
                            myInscriptions[index].eventWid,
                            myInscriptions[index].name,
                            myInscriptions[index].image,
                            myInscriptions[index].eventDate,
                            myInscriptions[index].extraData,
                            myInscriptions[index].quantity,
                            myInscriptions[index].participants,
                            myInscriptions[index].inscriptionFields,
                          );
                        })),
              ],
            ),
          );
  }
}
