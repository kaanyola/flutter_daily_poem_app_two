import 'package:dailypoemapptwo/api/siirApi.dart';
import 'package:dailypoemapptwo/model/Siir.dart';
import 'package:flutter/material.dart';
import 'package:dailypoemapptwo/HomePage.dart';
import 'package:dailypoemapptwo/FavPage.dart';
import 'package:dailypoemapptwo/model/FavSiirler.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static List<String> linesAga = ["Demirci", "Toynağı", "Moruk", "Aynen"];
  Siir siirMonitored = Siir(
      name: "Rezidanslar",
      poetName: "Ece Ayhan",
      lines: linesAga,
      favCount: 231);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Siir> futureSiir;
  

  @override
  void initState(){
    super.initState();
    futureSiir = fetchSiir();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.pink),
      title: "Daily Poem App",
      home: _tabController(context),
    );
  }

  DefaultTabController _tabController(BuildContext context) {
    color1 = Theme.of(context).primaryColor;
    color2 = Theme.of(context).bottomAppBarColor;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Center(
              child: Text(
            "Daily Poem App",
            style: TextStyle(color: Colors.black),
          )),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Material(
            color: Colors.pink,
            child: TabBar(
              indicatorColor: Colors.lime,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HomePage(futureSiir),
            FavPage(),
          ],
        ),
      ),
    );
  }
}

Color color1;
Color color2;
