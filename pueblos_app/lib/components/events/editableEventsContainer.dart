import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pueblos_app/authService.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:pueblos_app/model/event.dart';
import 'package:pueblos_app/apiCalls.dart';

import 'editableEventCard.dart';

class EditableEventsContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditableEventsContainerState();
}

class _EditableEventsContainerState extends State<EditableEventsContainer> {
  var events = List<Event>();
  bool isLoading = true;
  String _domain = "";
  String _activeVillageId ="";
  String token;

  _getEvents() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    _activeVillageId = userPrefs.getString('activeVillageId');
    token = userPrefs.getString('token');
    _domain = "https://vueltalpueblo.wisclic.es/";
    ApiCalls().getManagedEvents(_activeVillageId, token).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          Iterable list = json.decode(response.body)['data'];
          events = list.map((model) => Event.fromJson(model)).toList();
        });
        isLoading = false;
      } else {
        _getEvents();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getEvents();
    AuthService().refreshToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return EditableEventCard(
                      events[index].id.toString(),
                              events[index].image.toString(),
                              events[index].name,
                              events[index].description,
                              events[index].eventDate,
                              events[index].registrationInitDate,
                              events[index].registrationFinishDate,
                              events[index].price,
                              _domain
                    );
                  },
                ))
              ],
            ),
          );
  }
}
