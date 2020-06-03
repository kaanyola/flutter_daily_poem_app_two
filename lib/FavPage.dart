import 'package:dailypoemapptwo/SelectedPoemPage.dart';
import 'package:dailypoemapptwo/model/FavSiirler.dart';
import 'package:dailypoemapptwo/model/Siir.dart';
import 'package:flutter/material.dart';

import 'package:dailypoemapptwo/DenemeYapalim.dart';

class FavPage extends StatefulWidget {
  List<Siir> favPoems;
  FavSiirler favSiirler = FavSiirler();

  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.yellow, Colors.pink])),
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            child: Center(
              child: Text(
                "Favoriler",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3),
              ),
            ),
          ),
          favList()
        ],
      ),
    );
  }

  Widget favList() {
    if (widget.favSiirler.favoriSiirler.length == 0) {
      return Text(
        "Favoriniz bulunmamaktadır.",
        style: TextStyle(fontSize: 25),
      );
    } else {
      return Expanded(
        child: ListView.builder(
            itemCount: widget.favSiirler.favoriSiirler.length,
            itemBuilder: (context, int index) {
              return Container(
                decoration: BoxDecoration(border: Border.all()),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectedPoemPage(
                                      widget.favSiirler.favoriSiirler[index])))
                          .then((value) {
                        setState(() {});
                      });
                    });
                  },
                  title: Text(
                    widget.favSiirler.favoriSiirler[index].name,
                    style: TextStyle(fontSize: 22),
                  ),
                  subtitle: Text(
                    widget.favSiirler.favoriSiirler[index].poetName,
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: CircleAvatar(
                    child: Text(widget.favSiirler.favoriSiirler[index].name[0]),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                  trailing: RaisedButton(
                      color: Colors.black.withOpacity(0.7),
                      child: Icon(Icons.remove, color: Colors.white,),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DenemeYapalim()));
                      },
                    ),
                  ),
              );
            }),
      );
    }
  }

  void goSelectedPage(int index) {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SelectedPoemPage(widget.favSiirler.favoriSiirler[index])))
        .then((value) {
      setState(() {});
    });
  }
}
