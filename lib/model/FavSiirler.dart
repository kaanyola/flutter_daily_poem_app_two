import 'package:dailypoemapptwo/model/Siir.dart';

List<String> lines2 = [
  "Öyle sevdim ki seni",
  "Öylesine sensin ki!",
  "Kuşlar gibi cıvıldar",
  "Tattırdığın acılar."
];
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
    key: "şlgksdlgdlsg",
    id: 2,
    name: "Park",
    poetName: "Cemal Süreya",
    lines: lines,
    favCount: 354,
    inView: false,
    mood: "mutlu");
Siir siirB = new Siir(
    key: "fdlşgksdlşgksdl",
    id: 1,
    name: "Galata Kulesi",
    poetName: "Nazım Hikmet",
    lines: lines2,
    favCount: 147,
    inView: false,
    mood: "üzgün");

Siir siirC = new Siir(
    key: "şlgksdlgdlsg",
    id: 3,
    name: "Park",
    poetName: "Cemal Süreya",
    lines: lines,
    favCount: 354,
    inView: false,
    mood: "mutlu");
Siir siirD = new Siir(
    key: "fdlşgksdlşgksdl",
    id: 4,
    name: "Galata Kulesi",
    poetName: "Nazım Hikmet",
    lines: lines2,
    favCount: 147,
    inView: false,
    mood: "üzgün");

Siir siirE = new Siir(
    key: "şlgksdlgdlsg",
    id: 5,
    name: "Park",
    poetName: "Cemal Süreya",
    lines: lines,
    favCount: 354,
    inView: false,
    mood: "mutlu");
Siir siirF = new Siir(
    key: "fdlşgksdlşgksdl",
    id: 6,
    name: "Galata Kulesi",
    poetName: "Nazım Hikmet",
    lines: lines2,
    favCount: 147,
    inView: false,
    mood: "üzgün");

Siir siirG = new Siir(
    key: "şlgksdlgdlsg",
    id: 7,
    name: "Park",
    poetName: "Cemal Süreya",
    lines: lines,
    favCount: 354,
    inView: false,
    mood: "mutlu");
Siir siirH = new Siir(
    key: "fdlşgksdlşgksdl",
    id: 8,
    name: "Galata Kulesi",
    poetName: "Nazım Hikmet",
    lines: lines2,
    favCount: 147,
    inView: false,
    mood: "üzgün");

class FavSiirler {
  final List<Siir> favoriSiirler = [
    siirA,
    siirB,
    siirC,
    siirD,
    siirE,
    siirF,
    siirG,
    siirH
  ];

  static final FavSiirler _instance = FavSiirler._internal();

  FavSiirler._internal();

  factory FavSiirler() => _instance;
}
