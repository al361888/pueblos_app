import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/proclamation.dart';

class DBService {
  final CollectionReference villageCollection =
      Firestore.instance.collection('villages');
  String village;
  DBService(String village) {
    this.village = village;
  }

  Future addProclamation(
      String title, String description, String community) async {
    try {
      var ret = await villageCollection
          .document(village)
          .collection('proclamations')
          .add({
        "title": title,
        "description": description,
        "date": DateTime.now()
      }) as CollectionReference;

      return ret;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Proclamation>> getVillageProclamations() async {
    var result = List<Proclamation>();
    try {
      await villageCollection
          .document(village)
          .collection('proclamations')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          // print('${f.data}}');
          // print('${f.data['title']}');
          var proc = Proclamation(
              '${f.data['title']}',
              '${f.data['description']}',
              '${f.data['title']}',
              '${f.data['title']}');
          result.add(proc);
          //print(result.toString());
        });
      });
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
