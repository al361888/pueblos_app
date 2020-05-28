class Inscription{
  String wid;
  String eventWid;
  String name;
  String image;
  String eventDate;
  String extraData;
  String quantity;
  var participants;
  var inscriptionFields;
  String userName;
  String userImage;

  Inscription(this.wid, this.eventWid, this.name, this.image, this.eventDate, this.extraData, this.quantity, this.participants, this.inscriptionFields, this.userName, this.userImage);

  Inscription.fromJson(Map<String, dynamic> json)
      : wid = json['wid'],
      eventWid = json['widEvent'],
      name = json['name'],
      image =  json['image'],
      eventDate = json['eventDate'],
      extraData = json['extraData'],
      quantity = json['quantity'],
      participants = json['participants'],
      inscriptionFields = json['inscriptionFields'],
      userName = json['userName'],
      userImage = json['userImage'];

}