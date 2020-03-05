class News {
  String id;
  String image;
  String name;

  News(this.id, this.image, this.name);

  News.fromJson(Map<String, dynamic> json)
      : 
      id = json['id'],
        image = json['image'],
        name = json['name'];
  @override
  String toString() {
    return super.toString();
  }
}