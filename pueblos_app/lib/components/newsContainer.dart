import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pueblos_app/apiCalls.dart';
import "package:pueblos_app/components/newsElement.dart";
import 'package:pueblos_app/model/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  var news = List<News>();

  String _domain= "";

  _getNews() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();

    _domain = userPrefs.getString('activeDomain');

    ApiCalls(_domain).getNews().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)['data'];
        
        news = list.map((model) => News.fromJson(model)).toList();
        print(news.toString());
      });
    });
  }

  initState() {
    super.initState();
    _getNews();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 10)),
          Expanded(
            child: ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  print(_domain);
                  return NewsElement(news[index].id, news[index].image, news[index].name );
                }),
          ),
        ],
      ),
    );
  }
}


