import 'package:dailypoemapptwo/model/FavSiirler.dart';
import 'package:dailypoemapptwo/model/Siir.dart';
import 'package:dailypoemapptwo/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectedPoemPage extends StatefulWidget {
  FavSiirler favSiirler = FavSiirler();
  int id;
  int sendedId;
  String name;
  String poetName;
  int favCount;
  bool inView;
  Siir streamSiir;
  List<String> lines;
  Siir siirMonitored;
  SelectedPoemPage(this.sendedId);
  @override
  _SelectedPoemPageState createState() => _SelectedPoemPageState();
}

class _SelectedPoemPageState extends State<SelectedPoemPage> {
  String mood = "mutlu";
  FirebaseService service;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service = FirebaseService();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.pink),
      title: "Daily Poem App",
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow,
            title: Center(
              child: Text(
                "Daily Poem App",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Colors.pink, Colors.yellow])),
            child: Container(
              padding: EdgeInsets.all(5),
              color: Colors.black.withOpacity(0.4),
              margin: EdgeInsets.all(20),
              child: futureSiirCard(),
            ),
          )),
    );
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
    return FutureBuilder(
      future: service.getSelectedPoem(widget.sendedId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Text(snapshot.data.poetName,
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
                    Text(snapshot.data.name,
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
                    itemCount: snapshot.data.lines.length,
                    itemBuilder: (context, int index) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          snapshot.data.lines[index],
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
                    "${snapshot.data.favCount}",
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
                    children: <Widget>[Text("")],
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
}
