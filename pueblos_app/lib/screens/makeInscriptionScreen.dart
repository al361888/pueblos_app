import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MakeInscriptionScreen extends StatefulWidget{
  @override
  _MakeInscriptionScreenState createState() => _MakeInscriptionScreenState();
}

class _MakeInscriptionScreenState extends State<MakeInscriptionScreen> {
  bool isLoading;
  String token;
  String villageId;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  initState(){
    super.initState();
    isLoading = true;
    _getData();
  } 

  _getData() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    token = userPrefs.getString('token');
    villageId = userPrefs.getString('activeVillageId');
  }

  @override
  Widget build(BuildContext context) {
    String url = "https://vueltalpueblo.wisclic.es/"+ villageId + "/eventos/vap-event003/inscripcion";

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Realizar Inscripción",
            //style: TextStyle(color: Colors.white),
          )),
      body: Stack(
        children: <Widget>[
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
            javascriptChannels: <JavascriptChannel>[].toSet(),
            onWebViewCreated: (WebViewController webViewController) {
              Map <String, String> headers = {"Authorization": "Bearer " + token};
            webViewController.loadUrl(url, headers: headers);
            _controller.complete(webViewController);
          },
            onPageFinished: (String url) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? Center( child: CircularProgressIndicator()) : Container(),
        ],
      ),
    );
  }
}