class Siir{
  int id;
  String name;
  String poetName;
  List <dynamic> lines;
  int favCount;

  Siir({this.id, this.name, this.poetName, this.lines, this.favCount});

  factory Siir.fromJson(Map<String, dynamic> json){
    return Siir(
      id: json["data"][0]['id'],
      name: json["data"][0]['title'],
      poetName: json["data"][0]['sair'],
      lines: json["data"][0]['lines'],
      favCount: json["data"][0]['favCount']
    );
  }
}