import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pueblos_app/components/proclamationCard.dart';

class NewsElement extends StatefulWidget {
  String id;
  String image;
  String title;

  NewsElement(String id, String image, String name) {
    this.id = id;
    this.image = image;
    this.title = name;
  }

  @override
  State<StatefulWidget> createState() => _NewsElementState();
}

class _NewsElementState extends State<NewsElement> {
  String tiempoNoticia = calculateTimeDiff();

  @override
  Widget build(BuildContext context) {
    String id = widget.id;
    String image = widget.image;
    String title = widget.title;

    print(image);
    if(image==null){
      image = "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80";
    }else{
      
    }
    

    return Hero(
      tag: 'news$id',
      child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return DetailedNewsItem(id, title, image);
            }));
          },
          child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(image,
                        width: 100, height: 100, fit: BoxFit.cover,),
                  ),
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: Text(
                                title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Padding(padding: EdgeInsets.only(top:10)),
                          Container(
                            child: Text(
                                tiempoNoticia,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                        ]),
                  ),
                ],
              ))),
    );
  }
}

class DetailedNewsItem extends StatelessWidget {
  String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc volutpat arcu luctus augue hendrerit consequat. Aliquam non faucibus neque. Vestibulum condimentum nibh vel elit pellentesque, sit amet elementum ante semper. Quisque tristique turpis ac nulla lobortis, in cursus tellus porttitor. \n\nDuis sagittis tortor ex, a ullamcorper nunc imperdiet vitae. Maecenas facilisis efficitur faucibus. Nunc sit amet risus venenatis, placerat est facilisis, porta augue. Ut nec ligula at dui volutpat porttitor et vel mi. Sed nulla justo, interdum rutrum enim sed, tristique scelerisque sem. Quisque lacus augue, volutpat non pulvinar id, faucibus ac erat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin ultricies fringilla faucibus.\n\n Pellentesque non vestibulum lorem. Integer sollicitudin dolor ac ultrices congue. Vivamus elementum gravida diam a interdum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. ";
  
  String title;
  String id;
  String image;

  DetailedNewsItem(String id, String name, String image) {
    this.id = id;
    this.image = image;
    this.title = name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
        elevation: 0,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                  tag: 'news$id',
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(image))),
              Container(
                  decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.red, 
                  Colors.blue],
                  stops: [0.1, 0.8]
                  )),
                child: SelectableText(title,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(child: Html(data: loremIpsum * 4)),
            ),
          ),
        ],
      )),
    );
  }
}

/* Scaffold(backgroundColor: Colors.transparent,
                  appBar: AppBar(backgroundColor: Colors.transparent),
                  body: Container(
                    color: Colors.transparent,
                  ),
                  extendBodyBehindAppBar: true,
                  extendBody: true,
                ) */
