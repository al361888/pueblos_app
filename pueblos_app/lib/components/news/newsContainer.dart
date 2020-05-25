import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pueblos_app/apiCalls.dart';
import 'package:pueblos_app/authService.dart';
import 'package:pueblos_app/model/news.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'imageNewsCard.dart';
import 'newsElement.dart';

class NewsContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  var news = List<News>();
  bool isLoading = true;
  String _domain = "";
  String _activeVillageId = "";
  String token;

  _getNews() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    _activeVillageId = userPrefs.getString('activeVillageId');
    token = userPrefs.getString('token');
    _domain = "https://vueltalpueblo.wisclic.es/";

    if (token == null) {
      ApiCalls().getNews(_activeVillageId).then((response) {
        if (response.statusCode == 200) {
          setState(() {
            Iterable list = json.decode(response.body)['data'];
            news = list.map((model) => News.fromJson(model)).toList();
          });
          isLoading = false;
        } else {
          _getNews();
        }
      });
    } else {
      ApiCalls().getNewsLogged(_activeVillageId, token).then((response) {
        if (response.statusCode == 200) {
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
                        if (index == 0) {
                          return ImageNewsCard(
                              news[0].id,
                              news[0].image,
                              news[0].name,
                              news[0].description,
                              news[0].publishDate,
                              _domain);
                        } else {
                          return NewsElement(
                              news[index].id.toString(),
                              news[index].image.toString(),
                              news[index].name,
                              news[index].description,
                              news[index].publishDate,
                              _domain);
                        }
                      }),
                ),
              ],
            ),
          );
  }
}
