import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../authService.dart';



class AddNewsScreen extends StatefulWidget {
  @override
  _AddNewsScreenState createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  bool isLoading;
  String token;
  String villageWid;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  initState() {
    super.initState();
    isLoading = true;
    _getToken();
    AuthService().refreshToken();
  }

  _getToken() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      villageWid = userPrefs.getString('activeVillageId');
      token = userPrefs.getString('token');
    });
  }

  @override
  Widget build(BuildContext context) {
    String url = "https://vueltalpueblo.wisclic.es/m/"+ villageWid +"/news/create";
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Crear noticia",
            //style: TextStyle(color: Colors.white),
          )),
      body: Stack(
        children: <Widget>[
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
            javascriptChannels: <JavascriptChannel>[
              _newsAddedChannel(context),
            ].toSet(),
            onPageFinished: (String url) {
               setState(() {
                isLoading = false;
              });
            },
            onWebViewCreated: (WebViewController webViewController) {
                Map<String, String> headers = {
                  "Authorization": "Bearer " + token
                };
                webViewController.loadUrl(url, headers: headers);
                _controller.complete(webViewController);
              },
          ),
          isLoading ? Center( child: CircularProgressIndicator()) : Container(),
        ],
      ),
    );
  }

  JavascriptChannel _newsAddedChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'fcc',
        onMessageReceived: (JavascriptMessage message) {
          Map<String, dynamic> info = jsonDecode(message.message);
          MessageInfo newsInfo = MessageInfo.fromJson(info);
          print(newsInfo.success);
          if (newsInfo.success) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Noticia añadida correctamente."),));
            Navigator.pushNamed(context, '/HomeScreen');
          }
        });
  }
}

class MessageInfo {
  final bool success;

  MessageInfo(this.success);

  MessageInfo.fromJson(Map<String, dynamic> json) : success = json['success'];
}
