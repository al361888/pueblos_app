import 'package:flutter/material.dart';
import 'package:pueblos_app/components/proclamations/proclamationCard.dart';
import 'package:pueblos_app/model/proclamation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dbService.dart';

class ProclamationsContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProclamationContainer();
}

class _ProclamationContainer extends State<ProclamationsContainer> {
  var proclamations = List<Proclamation>();
  bool isLoading = true;
  String activeVillageId;

  _getProclamations() async {
    final userPrefs = await SharedPreferences.getInstance();
    activeVillageId = userPrefs.getString('activeVillageId');
    print(activeVillageId);
    var db = DBService(activeVillageId);

    db.getVillageProclamations().then((response) {
      setState(() {
        proclamations = response;
        isLoading = false;
      });
    });
  }

  @override
  initState() {
    super.initState();
    _getProclamations();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
          padding: EdgeInsets.only(top:10),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: proclamations.length,
                      itemBuilder: (context, index) {
                        return ProclamationCard(
                            proclamations[index].title,
                            proclamations[index].description,
                            proclamations[index].community,
                            proclamations[index].publicationDate);
                      }),
                )
              ],
            ),
          );
  }
}
