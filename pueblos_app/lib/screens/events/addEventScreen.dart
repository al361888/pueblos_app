import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
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
    String url = "https://vueltalpueblo.wisclic.es/m/"+ villageWid +"/events/create";
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Crear Evento",
            //style: TextStyle(color: Colors.white),
          )),
      body: Stack(
        children: <Widget>[
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
            javascriptChannels: <JavascriptChannel>[_webViewChannel(context)].toSet(),
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

  JavascriptChannel _webViewChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'fcc',
        onMessageReceived: (JavascriptMessage message) {
          Map<String, dynamic> info = jsonDecode(message.message);
          MessageInfo newsInfo = MessageInfo.fromJson(info);
          print(newsInfo.success);
          if (newsInfo.success) {
            Navigator.pop(context);
          }
        });
  }
}
class MessageInfo {
  final bool success;

  MessageInfo(this.success);

  MessageInfo.fromJson(Map<String, dynamic> json) : success = json['success'];
}