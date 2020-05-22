import 'dart:convert';

class User{
  final String email;
  final String name;
  final String username;
  final managedVillages;
  final String token;

  User({this.email, this.name, this.username, this.managedVillages, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['data']['user']['email'],
      name: json["data"]['user']['name'],
      managedVillages: json["data"]['user']['managedVillages'],
      token: json["data"]['token']
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'username': username,
    'managedVillages': managedVillages
  };
}

