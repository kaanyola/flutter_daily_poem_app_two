import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailypoemapptwo/HomePage.dart';

class DenemeYapalim extends StatefulWidget {
  @override
  _DenemeYapalimState createState() => _DenemeYapalimState();
}

class _DenemeYapalimState extends State<DenemeYapalim> {
  final databaseReference = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    getData();
    return StreamBuilder(
      stream: databaseReference.collection("poems").snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Text(snapshot.data.documents[0]['name']);
        }
        return Text("kdsjfks");
      },
    );
  }

  void getData() {
    databaseReference
        .collection("crazy")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }
}
