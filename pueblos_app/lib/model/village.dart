class Village {
  String id;
  String name;
  String image;
  String nameUrl;

  Village(String id, String name, String image, String nameUrl) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.nameUrl = nameUrl;
  }

  Village.fromJson(Map<String, dynamic> json)
      : id = json['wid'],
      name = json['name'],
      image = json['image'],
      nameUrl = json['nameUrl'];
}
