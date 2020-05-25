import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pueblos_app/authService.dart';
import 'package:pueblos_app/model/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiCalls.dart';
import 'editableNewsElement.dart';

class EditableNewsContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditableNewsContainerState();
}

class _EditableNewsContainerState extends State<EditableNewsContainer> {
  var news = List<News>();
  bool isLoading = true;

  String _domain = "";
  String _activeVillageId = "";
  String token;

  _getNews() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    _activeVillageId = userPrefs.getString('activeVillageId');
    _domain = "https://vueltalpueblo.wisclic.es";
    token = userPrefs.getString('token');

    ApiCalls().getManagedNews(_activeVillageId, token).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          Iterable list = json.decode(response.body)['data'];
          news = list.map((model) => News.fromJson(model)).toList();
        });
        isLoading = false;
      } else {
        _getNews();
      }
    });
  }

  @override
  initState() {
    super.initState();
    _getNews();
    AuthService().refreshToken();
  }

  dispose() {
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
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        return EditableNewsElement(
                            news[index].id.toString(),
                            news[index].image.toString(),
                            news[index].name,
                            news[index].description,
                            news[index].publishDate,
                            _domain,
                            news[index].active);
                      }),
                ),
              ],
            ),
          );
  }
}
