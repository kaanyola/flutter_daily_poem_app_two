class Siir {
  String key;
  int id;
  String name;
  String poetName;
  List<String> lines;
  bool inView;
  int favCount;
  String mood;

  Siir(
      {this.key,
      this.id,
      this.name,
      this.poetName,
      this.lines,
      this.inView,
      this.favCount,
      this.mood});

  Siir.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    id = json['id'];
    name = json['name'];
    poetName = json['poetName'];
    lines = json['lines'].cast<String>();
    inView = json['inView'];
    favCount = json['favCount'];
    mood = json['mood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['id'] = this.id;
    data['name'] = this.name;
    data['poetName'] = this.poetName;
    data['lines'] = this.lines;
    data['inView'] = this.inView;
    data['favCount'] = this.favCount;
    data['mood'] = this.mood;
    return data;
  }
}
