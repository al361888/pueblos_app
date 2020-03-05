import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'model/user.dart';

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
      var user=User.fromJson(convertToData);

      var email = user.email;
      var name = user.name;
      var activeVillage = user.activeVillage;
      var activeName = user.activeName;
      var activeDomain = user.activeDomain;

      print(activeVillage);
      print(activeName);
      print(activeDomain);

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

