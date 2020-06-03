import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:dailypoemapptwo/model/Siir.dart';

Future<Siir> fetchSiir() async{
  final response = await http.get('https://api.npoint.io/f94694df72e3118d1e22');

  if(response.statusCode == 200){
    return Siir.fromJson(json.decode(response.body));
  }
  else{
    throw Exception("Yükleme başarısız");
  }
}