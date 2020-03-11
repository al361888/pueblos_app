import 'package:flutter/cupertino.dart';

class DetailedEvent extends StatelessWidget{

  String id;
  String image;
  String name;
  String description;
  String active;
  String eventDate;
  String registrationInitDate;
  String registrationFinishDate;
  String price;

  DetailedEvent(
      String id,
      String image,
      String name,
      String description,
      String eventDate,
      String registrationInitDate,
      String registrationFinishDate,
      String price) {
    this.id = id;
    this.image = image;
    this.name = name;
    this.description = description;
    this.eventDate = eventDate;
    this.registrationInitDate = registrationInitDate;
    this.registrationFinishDate = registrationFinishDate;
    this.price = price;
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }

}