import 'dart:convert';

class User{
  final String email;
  final String name;
  final villages;
  final activeVillage;
  final String activeName;
  final String activeDomain;

  User({this.email, this.name, this.villages, this.activeVillage, this.activeName, this.activeDomain});

  factory User.fromJson(Map<String, dynamic> json) {
    var villages=Map.from(json["data"]['villages']);
    var activeVillage=(villages.values.toList().length>0)?villages.values.toList()[0]:null;

    return User(
      email: json["data"]['email'],
      name: json["data"]['name'],
      villages: jsonEncode(villages),
      activeVillage: activeVillage!=null?activeVillage['id']:null,
      activeName: activeVillage!=null?activeVillage['name']:null,
      activeDomain: activeVillage!=null?activeVillage['domain']:null
    );
  }
}
