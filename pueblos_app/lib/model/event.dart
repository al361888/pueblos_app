class Event {
  String id;
  String image;
  String name;
  String description;
  String active;
  String eventDate;
  String registrationInitDate;
  String registrationFinishDate;
  String price;

  Event(
      this.id,
      this.image,
      this.name,
      this.description,
      this.active,
      this.eventDate,
      this.registrationInitDate,
      this.registrationFinishDate,
      this.price);

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        name = json['name'],
        description = json['description'],
        active = json['active'],
        eventDate = json['eventDate'],
        registrationInitDate = json['registrationInitDate'],
        registrationFinishDate = json['registrationFinishDate'],
        price = json['price'];

  @override
  String toString() {
    return super.toString();
  }
}
