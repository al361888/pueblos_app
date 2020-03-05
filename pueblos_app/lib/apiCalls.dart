import 'dart:async';
import 'package:http/http.dart' as http;


class ApiCalls {
  
  String baseUrl;

  ApiCalls(String url){
    this.baseUrl = url;
  }
  

  Future getNews(){
    var url = baseUrl+"/api/news";
    return http.get(url);
  }

  Future getEvents(){
    var url = this.baseUrl + "/api/events";
    return http.get(url);
  }
}
