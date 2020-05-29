import 'package:flutter/material.dart';
import 'package:pueblos_app/screens/news/editNewsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiCalls.dart';
import 'detailedNewsItem.dart';

class EditableNewsElement extends StatefulWidget {
  String id;
  String image;
  String title;
  String description;
  String publishDate;
  String domain;
  String active;

  EditableNewsElement(String id, String image, String name, String description,
      String publishDate, String domain, String active) {
    this.id = id;
    this.image = image;
    this.title = name;
    this.description = description;
    this.publishDate = publishDate;
    this.domain = domain;
    this.active = active;
  }

  @override
  State<StatefulWidget> createState() => _EditableNewsElementState();
}

class _EditableNewsElementState extends State<EditableNewsElement> {
  String activeVillageWid;
  String token;

  @override
  initState() {
    super.initState();
    _getVillageId();
  }

  @override
  dispose() {
    super.dispose();
  }

  _getVillageId() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      activeVillageWid = userPrefs.getString('activeVillageId');
      token = userPrefs.getString('token');
    });
  }

  @override
  Widget build(BuildContext context) {
    String domain = widget.domain;
    String id = widget.id;
    String image = widget.image;
    String title = widget.title;
    String description = widget.description;
    String publishDate = widget.publishDate;

    String tiempoNoticia = calculateTimeDiff(publishDate);
    if (image != null) {
      image = domain + "/files/" + image;
    } else {
      image =
          "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80";
    }

    bool hidden;
    if(widget.active == '0'){
      hidden = true;
    }else{
      hidden = false;
    }

    return Hero(
      tag: 'news$id',
      child: Material(
        child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailedNewsItem(
                    id, title, image, description, publishDate);
              }));
            },
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              child: Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image: image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )),
                          Container(
                              decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.1, 0.8],
                              colors: [Color(0xCC272741), Color(0x00272741)],
                            ),
                          )),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                child: Text(title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Padding(padding: EdgeInsets.only(top: 9)),
                              Container(
                                child: Text(
                                  tiempoNoticia,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14),
                                ),
                              ),
                              widget.active == "0"
                                  ? Container(
                                      child: Text("Oculta",
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Color(0xFFF39EB3))))
                                  : Container(),
                            ]),
                      ),
                      Container(
                        child: PopupMenuButton<int>(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.visibility_off,
                                      color: Colors.grey),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  hidden?Text("Visibilizar noticia",
                                      style:
                                          TextStyle(color: Color(0xFF1E2C41))):Text("Ocultar noticia",
                                      style:
                                          TextStyle(color: Color(0xFF1E2C41)))
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.edit, color: Colors.grey),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("Editar noticia",
                                      style:
                                          TextStyle(color: Color(0xFF1E2C41))),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 3,
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.delete, color: Colors.grey),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Text("Eliminar noticia",
                                      style:
                                          TextStyle(color: Color(0xFF1E2C41))),
                                ],
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 1) {
                              String success = _hideNews(activeVillageWid,
                                  widget.id, widget.active, token);
                              print(success);
                              setState(() {
                                          widget.active = success;
                                        });
                              if (success == '1') {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content:
                                        Text("Noticia visible")));
                                Navigator.pushNamedAndRemoveUntil(context, "/HomeScreen", (route) => false);
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content:
                                        Text("Noticia ocultada")));
                                        Navigator.pushNamedAndRemoveUntil(context, "/HomeScreen", (route) => false);
                              }
                            } else if (value == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditNewsScreen(id)));
                            } else if (value == 3) {
                              if (_deleteNews(
                                  activeVillageWid, widget.id, token)) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Noticia eliminada correctamente")));
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/ConfigNews',
                                    (Route<dynamic> route) => false);
                              }
                            }
                          },
                        ),
                      )
                    ],
                  )),
            )),
      ),
    );
  }

  String _hideNews(
      String activeVillageWid, String id, String active, String token) {
    ApiCalls()
        .hideNews(activeVillageWid, widget.id, widget.active, token)
        .then((result) {
    });
    if(active=='0'){
      return '1';
    }else{
      return '0';
    }
  }

  bool _deleteNews(String activeVillageWid, String id, String token) {
    var res;
    ApiCalls().deleteNews(activeVillageWid, id, token).then((response) {
      res=response;
    });
    print(res);
    return true;
  }
}
