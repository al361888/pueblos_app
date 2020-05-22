import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pueblos_app/model/village.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'messageHandler.dart';
import 'model/user.dart';

class AuthService {
  // Login
  Future<bool> login(String user, String pass) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String password = stringToBase64.encode(pass); 

    var uriResponse = await http.post(
        'https://vueltalpueblo.wisclic.es/api/loginc',
        body: {'user': user, 'pass': password});

    if (uriResponse.statusCode == 200) {
      print(uriResponse.body.toString());

      // obtain shared preferences
      final userPrefs = await SharedPreferences.getInstance();

      var convertToData = json.decode(uriResponse.body);
      var user = User.fromJson(convertToData);
      
      var email = user.email;
      var name = user.name;

      // set values into sharedPreferences
      userPrefs.setString('userName', name);
      userPrefs.setString('email', email);
      userPrefs.setString('token', user.token);
      print(user.managedVillages);
      userPrefs.setString('managedVillages', json.encode(user.managedVillages));

      //Store username and password locally
      final storage = new FlutterSecureStorage();
      await storage.write(key: 'username', value: name);
      await storage.write(key: 'password', value: pass);

      // MessageHandler messageHandler = MessageHandler(); ====================================
      // messageHandler.fcmSubscribe("VillanuevaDeViver"); ====================================

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
    userPrefs.remove("userName");
    userPrefs.remove("email");

    final storage = new FlutterSecureStorage();
    storage.deleteAll();

    MessageHandler messageHandler = MessageHandler();
    messageHandler.fcmUnSubscribe("VillanuevaDeViver");

    return await new Future<void>.delayed(new Duration(seconds: 1));
  }

  //Función que comprueba si la sesión está iniciada
  Future<bool> checkFirstLogin() async {
    final storage = new FlutterSecureStorage();

    String value = await storage.read(key: 'username');

    if (value == null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> loginWithoutAccount(Village selectedVillage) async {
    final userPrefs = await SharedPreferences.getInstance();
    userPrefs.setString('activeVillageName', selectedVillage.name);
    userPrefs.setString('activeVillageId', selectedVillage.id);
    userPrefs.setString('activeVillageImage', selectedVillage.image);
    userPrefs.setString('activeVillageUrl', selectedVillage.nameUrl);
    // MessageHandler messageHandler = MessageHandler();
    // messageHandler.fcmSubscribe("VillanuevaDeViver");
  }
}
