class News {
  String id;
  String image;
  String name;
  String description;
  String active;
  String publishDate;


  News(this.id, this.image, this.name, this.description, this.active, this.publishDate);

  News.fromJson(Map<String, dynamic> json)
      : 
      id = json['id'],
        image = json['image'],
        name = json['name'],
        description = json['description'],
        active = json['active'],
        publishDate = json['publishDate'];

  @override
  String toString() {
    return super.toString();
  }
}