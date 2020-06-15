import 'dart:convert';
import 'dart:io';

import 'package:dailypoemapptwo/model/Siir.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  static const String FIREBASE_URL = "https://futuredeneme.firebaseio.com/";

  Future<List<Siir>> getPoems() async {
    final response = await http.get("$FIREBASE_URL/poems.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body) as Map;
        final siirList = List<Siir>();

        jsonModel.forEach((key, value) {
          final siir = Siir.fromJson(value);
          siir.key = key;
          siirList.add(siir);
        });

        return siirList;
      default:
        return Future.error(response.statusCode);
    }
  }

  Future<Siir> getMonitoredPoem(String mood) async {
    final response = await http.get("$FIREBASE_URL/poems.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body) as Map;
        var siirMonitored = Siir();

        jsonModel.forEach((key, value) {
          final siir = Siir.fromJson(value);
          if (siir.inView == true && siir.mood == mood) {
            siirMonitored = siir;
            return siirMonitored;
          }
          return siirMonitored;
        });

        return siirMonitored;
      default:
        return Future.error(response.statusCode);
    }
  }

  Future<Siir> getSelectedPoem(int id) async {
    final response = await http.get("$FIREBASE_URL/poems.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body) as Map;
        var siirSelected = Siir();

        jsonModel.forEach((key, value) {
          final siir = Siir.fromJson(value);
          if (siir.id == id) {
            siirSelected = siir;
            return siirSelected;
          }
          return siirSelected;
        });

        return siirSelected;
      default:
        return Future.error(response.statusCode);
    }
  }
}
