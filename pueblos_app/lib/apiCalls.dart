import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiCalls {
  String baseUrl;

  ApiCalls() {
    this.baseUrl = "https://vueltalpueblo.wisclic.es";
  }

  Future getNews(String villageId) {
    var url = baseUrl + "/api/" + villageId + "/news";
    return http.get(url);
  }

  Future getNewsLogged(String villageId, String token) {
    var url = baseUrl + "/api/" + villageId + "/news";
    return http.get(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token});
  }

  Future getManagedNews(String villageId, String token) {
    var url = baseUrl + "/api/" + villageId + "/news/managed";
    return http.get(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token});
  }

  Future getEvents(String villageId) {
    var url = this.baseUrl + "/api/" + villageId + "/events";
    return http.get(url);
  }

  Future getManagedEvents(String villageId, String token) {//=================================================COMPROBAR URL=============================================
    var url = baseUrl + "/api/" + villageId + "/events/managed";
    return http.get(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token});
  }

  Future getVillages() {
    var url = this.baseUrl + "/api/villages";
    return http.get(url);
  }

  Future<bool> hideEvent(
      String villageWid, String eventWid, String active, String token) async {
    String act;
    var url = this.baseUrl + "/api/" + villageWid + "/events/" + eventWid;
    if (active == '0') {
      act = '1';
    } else {
      act = '0';
    }

    final http.Response response = await http.put(url,
        headers: <String, String>{
          "Authorization": "Bearer " + token,
        },
        body: jsonEncode(<String, String>{
          "active": act,
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hideNews(
      String villageWid, String newsWid, String active, String token) async {
    String act;
    var url = this.baseUrl + "/api/" + villageWid + "/news/" + newsWid;
    if (active == '0') {
      act = '1';
    } else {
      act = '0';
    }

    final http.Response response = await http.put(url,
        headers: <String, String>{
          "Authorization": "Bearer " + token,
        },
        body: <String, String>{
          "active": act,
        });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}