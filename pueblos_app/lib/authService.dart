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
      print(uriResponse.body.toString());
      
      // obtain shared preferences
      final userPrefs = await SharedPreferences.getInstance();

      var convertToData = json.decode(uriResponse.body);
      var user=Post.fromJson(convertToData);

      var email = user.email;
      var name = user.name;
      var activeVillage = user.activeVillage;
      var activeName = user.activeName;
      var activeDomain = user.activeDomain;

      print(activeVillage);

      // set value
      userPrefs.setString('user', name);
      userPrefs.setString('email', email);
      userPrefs.setString('activeVillage', activeVillage);
      userPrefs.setString('activeName', activeName);
      userPrefs.setString('activeDomain', activeDomain);

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
    final userPrefs = await SharedPreferences.getInstance();
    userPrefs.remove("user");
    userPrefs.remove("email");
    return await new Future<void>.delayed(new Duration(seconds: 1));
  }
}

class Post{
  final String email;
  final String name;
  final villages;
  final activeVillage;
  final String activeName;
  final String activeDomain;

  Post({this.email, this.name, this.villages, this.activeVillage, this.activeName, this.activeDomain});

  factory Post.fromJson(Map<String, dynamic> json) {
    var villages=Map.from(json["data"]['villages']);
    var activeVillage=(villages.values.toList().length>0)?villages.values.toList()[0]:null;

    return Post(
      email: json["data"]['email'],
      name: json["data"]['name'],
      villages: jsonEncode(villages),
      activeVillage: activeVillage!=null?activeVillage[2]:null,
      activeName: activeVillage!=null?activeVillage[0]:null,
      activeDomain: activeVillage!=null?activeVillage[1]:null
    );
  }
}
