import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'myInscriptionsScreen.dart';

class AddInscriptionScreen extends StatefulWidget {
  String eventId;

  AddInscriptionScreen(String eventId) {
    this.eventId = eventId;
  }

  @override
  State<StatefulWidget> createState() => _AddInscriptionScreenState();
}

class _AddInscriptionScreenState extends State<AddInscriptionScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool isLoading;
  String token;
  String villageWid;

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
    String eventId = widget.eventId;

    String url = "https://vueltalpueblo.wisclic.es/m/" +
        villageWid +
        "/events/" +
        eventId +
        "/inscription";
    return Scaffold(
      appBar: AppBar(
        title: Text("Hacer inscripción"),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              javascriptChannels:
                  <JavascriptChannel>[_webViewChannel(context)].toSet(),
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
              }),
          isLoading ? Center(child: CircularProgressIndicator()) : Container(),
        ],
      ),
    );
  }

  JavascriptChannel _webViewChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'fcc',
        onMessageReceived: (JavascriptMessage message) {
          if (message.message == "go-back") {
            Navigator.pop(context);
          }
          if (message.message == "go-inscriptions") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyInscriptionsScreen()));
          }
        });
  }
}
