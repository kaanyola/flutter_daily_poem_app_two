import 'package:dailypoemapptwo/model/FavSiirler.dart';
import 'package:dailypoemapptwo/model/Siir.dart';
import 'package:flutter/material.dart';

class SelectedPoemPage extends StatefulWidget {
  FavSiirler favSiirler = FavSiirler();
  Siir siirSelected;
  SelectedPoemPage(this.siirSelected);
  @override
  _SelectedPoemPageState createState() => _SelectedPoemPageState();
}

class _SelectedPoemPageState extends State<SelectedPoemPage> {
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
          child: siirCard(context),
        ),
      ),
    );
  }

  Widget siirCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.black.withOpacity(0.4),
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text(widget.siirSelected.poetName,
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
                Text(widget.siirSelected.name,
                    style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          Flexible(
            flex: 100,
            child: ListView.builder(
                itemCount: widget.siirSelected.lines.length,
                itemBuilder: (context, int index) {
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.siirSelected.lines[index],
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
                "${widget.siirSelected.favCount}",
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
                children: <Widget>[butonSec(), iconSec()],
              ),
            ),
            onPressed: () {
              setState(() {
                if (widget.favSiirler.favoriSiirler.contains(widget.siirSelected)) {
                  widget.favSiirler.favoriSiirler.remove(widget.siirSelected);
                  widget.siirSelected.favCount--;
                }
                else{
                  widget.favSiirler.favoriSiirler.add(widget.siirSelected);
                  widget.siirSelected.favCount++;
                }
              });
            },
          )
        ],
      ),
    );
  }

  Widget butonSec() {
    if (widget.favSiirler.favoriSiirler.contains(widget.siirSelected)) {
      return Text("Favoriden Çıkart", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),);
    } else {
      return Text("Favorilere Ekle",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14));
    }
  }

  Widget iconSec(){
    if (widget.favSiirler.favoriSiirler.contains(widget.siirSelected)) {
      return Icon(Icons.remove, size: 14,);
    } else {
      return Icon(Icons.favorite_border, size: 14,);
    }
  }
}
