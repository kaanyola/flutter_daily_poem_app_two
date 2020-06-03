import 'package:dailypoemapptwo/model/FavSiirler.dart';
import 'package:flutter/material.dart';
import 'package:dailypoemapptwo/api/siirApi.dart';
import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/Siir.dart';

class HomePage extends StatefulWidget {
  Siir siirMonitored;
  Future<Siir> futureSiir;
  HomePage(this.futureSiir);
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
        child: Container(
          padding: EdgeInsets.all(5),
          color: Colors.black.withOpacity(0.4),
          margin: EdgeInsets.all(20),
          child: futureSiirCard(),
        ));
  }

  Widget siirCard(BuildContext context) {
    return deneme();
  }

  Widget butonSec(var snapshot) {
    if (widget.favSiirler.favoriSiirler.contains(snapshot.data)) {
      return Text(
        "Favoriden Çıkart",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      );
    } else {
      return Text("Favorilere Ekle",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14));
    }
  }

  Widget iconSec(var snapshot) {
    if (widget.favSiirler.favoriSiirler.contains(snapshot.data)) {
      return Icon(Icons.remove, size: 14);
    } else {
      return Icon(
        Icons.favorite_border,
        size: 14,
      );
    }
  }

  Widget futureSiirCard() {
    return StreamBuilder(
      stream: Firestore.instance.collection('poems').snapshots(),
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
                    children: <Widget>[butonSec(snapshot), iconSec(snapshot)],
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if (widget.favSiirler.favoriSiirler
                        .contains(snapshot.data)) {
                      widget.favSiirler.favoriSiirler.remove(snapshot.data);
                      snapshot.data.documents["favcount"]--;
                    } else {
                      widget.favSiirler.favoriSiirler.add(snapshot.data);
                      snapshot.data.favCount++;
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


   Widget deneme() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("crazy").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.data.documents == null) {
          return Text(snapshot.data.documents.length.toString());}
        return ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document){
            return ListTile(
              title: Text(document['name']),
              subtitle: Text(document['status']),
            );
          }).toList(),
        );
      },
    );
  }

  getData() async{
    return await Firestore.instance.collection('poems').getDocuments();
  }

}
