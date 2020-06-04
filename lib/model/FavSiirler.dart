import 'package:dailypoemapptwo/model/Siir.dart';

List<dynamic> lines2 = ["Öyle sevdim ki seni",
  "Öylesine sensin ki!",
  "Kuşlar gibi cıvıldar",
  "Tattırdığın acılar."];
List<dynamic> lines = [
  "Öyle sevdim ki seni",
  "Öylesine sensin ki!",
  "Kuşlar gibi cıvıldar",
  "Tattırdığın acılar.",
  "Öyle sevdim ki seni",
  "Öylesine sensin ki!",
  "Kuşlar gibi cıvıldar",
  "Tattırdığın acılar.",
  "Öyle sevdim ki seni",
  "Öylesine sensin ki!",
  "Kuşlar gibi cıvıldar",
  "Tattırdığın acılar.",
  "Öyle sevdim ki seni",
  "Öylesine sensin ki!",
  "Kuşlar gibi cıvıldar",
  "Tattırdığın acılar.",
  "Öyle sevdim ki seni",
  "Öylesine sensin ki!",
  "Kuşlar gibi cıvıldar",
  "Tattırdığın acılar."
];
Siir siirA = new Siir(id: 2,
    name: "Park", poetName: "Cemal Süreya", lines: lines, favCount: 354, inView: false);
    Siir siirB = new Siir(id: 1, name: "Galata Kulesi", poetName: "Nazım Hikmet", lines: lines2, favCount: 147, inView: false);

class FavSiirler{
  List<Siir> favoriSiirler = [siirA, siirB];

  static final FavSiirler _favoriSiirler = FavSiirler._internal();

  FavSiirler._internal();

  factory FavSiirler(){
    return _favoriSiirler;
  }
}