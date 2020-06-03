import 'package:dailypoemapptwo/model/Siir.dart';

List<String> lines2 = ["Öyle sevdim ki seni",
  "Öylesine sensin ki!",
  "Kuşlar gibi cıvıldar",
  "Tattırdığın acılar."];
List<String> lines = [
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
Siir siirA = new Siir(
    name: "Park", poetName: "Cemal Süreya", lines: lines, favCount: 354);
    Siir siirB = new Siir(name: "Galata Kulesi", poetName: "Nazım Hikmet", lines: lines2, favCount: 147);

class FavSiirler{
  List<Siir> favoriSiirler = [siirA, siirB];

  static final FavSiirler _favoriSiirler = FavSiirler._internal();

  FavSiirler._internal();

  factory FavSiirler(){
    return _favoriSiirler;
  }
}