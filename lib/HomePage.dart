import 'package:dailypoemapptwo/model/FavSiirler.dart';
import 'package:flutter/material.dart';
import 'package:dailypoemapptwo/api/siirApi.dart';
import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/Siir.dart';

class HomePage extends StatefulWidget {
  int id;
  String name;
  String poetName;
  int favCount;
  bool inView;
  Siir streamSiir;
  List<dynamic> lines;
  Siir siirMonitored;
  Future<Siir> futureSiir;
  HomePage(this.streamSiir);
  FavSiirler favSiirler = FavSiirler();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.pink, Colors.yellow])),
        child: Column(
          children: <Widget>[
            tagContainer(),
            Flexible(
                          child: Container(
                padding: EdgeInsets.all(5),
                color: Colors.black.withOpacity(0.4),
                margin: EdgeInsets.all(20),
                child: futureSiirCard(),
              ),
            ),
          ],
        ));
  }

  Widget butonSec(DocumentSnapshot doc) {
    getData(doc);
    for (int i = 0; i < widget.favSiirler.favoriSiirler.length; i++) {
      if (widget.favSiirler.favoriSiirler[i].id == widget.siirMonitored.id) {
        return Text(
          "Favoriden Çıkart",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        );
      }
    }

    return Text("Favorilere Ekle",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14));
  }

  Widget iconSec(DocumentSnapshot doc) {
    getData(doc);
    for (int i = 0; i < widget.favSiirler.favoriSiirler.length; i++) {
      if (widget.favSiirler.favoriSiirler[i].id == widget.siirMonitored.id) {
        return Icon(Icons.remove, size: 14);
      }
    }
    return Icon(
      Icons.favorite_border,
      size: 14,
    );
  }

  Widget futureSiirCard() {
    return StreamBuilder(
      stream: Firestore.instance.collection("poems")
.where("inView", isEqualTo: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Text(snapshot.data.documents[0]['poetName'],
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 20,
                          fontStyle: FontStyle.italic)),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(snapshot.data.documents[0]['name'],
                        style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
              Flexible(
                flex: 100,
                child: ListView.builder(
                    itemCount: snapshot.data.documents[0]['lines'].length,
                    itemBuilder: (context, int index) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          snapshot.data.documents[0]['lines'][index],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "${snapshot.data.documents[0]['favCount']}",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                  )
                ],
              ),
              Spacer(),
              RaisedButton(
                child: Container(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      butonSec(snapshot.data.documents[0]),
                      iconSec(snapshot.data.documents[0])
                    ],
                  ),
                ),
                onPressed: () {
                  setState(() {
                    getData(snapshot.data.documents[0]);
                    bool varMi = false;
                    for (int i = 0;
                        i < widget.favSiirler.favoriSiirler.length;
                        i++) {
                      if (widget.favSiirler.favoriSiirler[i].id ==
                          widget.siirMonitored.id) {
                        varMi = true;
                        break;
                      }
                    }
                    if (varMi) {
                      print(varMi);
                      getData(snapshot.data.documents[0]);
                      widget.favSiirler.favoriSiirler.removeWhere(
                          (item) => item.id == widget.siirMonitored.id);
                      snapshot.data.documents[0].reference.updateData({
                        'favCount': snapshot.data.documents[0]['favCount'] - 1
                      });
                    } else {
                      getData(snapshot.data.documents[0]);
                      widget.favSiirler.favoriSiirler.add(widget.siirMonitored);
                      snapshot.data.documents[0].reference.updateData({
                        'favCount': snapshot.data.documents[0]['favCount'] + 1
                      });
                    }
                  });
                },
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return Center(
          child: Container(height: 30, child: CircularProgressIndicator()),
        );
      },
    );
  }

  void getData(DocumentSnapshot doc) {
    widget.name = doc['name'];
    widget.id = doc['id'];
    widget.poetName = doc['poetName'];
    widget.lines = doc['lines'];
    widget.favCount = doc['favCount'];
    widget.inView = doc['inView'];
    widget.siirMonitored = Siir(
        id: widget.id,
        name: widget.name,
        poetName: widget.poetName,
        lines: widget.lines,
        favCount: widget.favCount,
        inView: widget.inView);
  }

  Widget deneme() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("crazy").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.data.documents == null) {
          return Text(snapshot.data.documents.length.toString());
        }
        return ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return ListTile(
              title: Text(document['name']),
              subtitle: Text(document['status']),
            );
          }).toList(),
        );
      },
    );
  }

  Future getPosts() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection("poems").getDocuments();
    return qn.documents;
  }

  Widget tagContainer() {
    return Container(
      height: 40,
      child: ListView(
        padding: EdgeInsets.only(left: 5),
        scrollDirection: Axis.horizontal,
        children: getTags(),
        shrinkWrap: false,
      ),
    );
  }

  List<Widget> getTags() {
    List<Widget> tags = [];
    for (int i = 0; i < 7; i++) {
      tags.add(Container(
        margin: EdgeInsets.only(left: 10),
        child: new FlatButton(
          child: Text(tagList[i],),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(width: 0.5)
          ),
          onPressed: () {

          },
        ),
      ));
    }
    return tags;
  }

  List<String> tagList = [
    "All",
    "Today",
    "Continue watiching",
    "Unwathced",
    "Trending",
    "Programming",
    "Python"
  ];
}
