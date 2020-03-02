import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Login
  Future<bool> login(String user, String pass) async {
    var uriResponse = await http.post(
        'https://mas.villanuevadeviver.es/api/login',
        body: {'user': user, 'pass': pass});

    if (uriResponse.statusCode == 200) {
      print(uriResponse.statusCode);
      print(uriResponse.body.toString());
      
      // obtain shared preferences
      final userPrefs = await SharedPreferences.getInstance();

      // set value
      userPrefs.setString('user', Post.fromJson(json.decode(uriResponse.body)).name);
      userPrefs.setString('email', Post.fromJson(json.decode(uriResponse.body)).email); 

      return true;
      
    } else {
      print(uriResponse.statusCode);
      print("No existe ese usuario");
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    // Simulate a future for response after 1 second.
    return await new Future<void>.delayed(new Duration(seconds: 1));
  }
}

class Post{
  final String email;
  final String name;

  Post({this.email, this.name});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      email: json['email'],
      name: json['name'],
    );
  }
}
