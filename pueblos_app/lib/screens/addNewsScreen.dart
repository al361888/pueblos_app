import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pueblos_app/model/news.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddNewsScreen extends StatefulWidget{
  @override
  _AddNewsScreenState createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Crear noticia",
            //style: TextStyle(color: Colors.white),
          )),
      body: WebView(
        initialUrl: "https://vueltalpueblo.wisclic.es/noticias/nueva",
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
        javascriptChannels: <JavascriptChannel>[
            _newsAddedChannel(context),
          ].toSet(),
      ),
    );
  }

  JavascriptChannel _newsAddedChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'addNews',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
          Map<String, dynamic> info = jsonDecode(message.message);
          NewsInfo newsInfo = NewsInfo.fromJson(info);
          print(newsInfo.success);
          if(newsInfo.success){
            print("Llega hasta aqui");
            Navigator.pop(context);
          }
        });
  }
}

class NewsInfo{
  final bool success;

  NewsInfo(this.success);

  NewsInfo.fromJson(Map<String, dynamic> json):
    success = json['success'];
}