class Insignia {
  String name;
  String desc;

  Insignia(this.name, this.desc);

  factory Insignia.fromJson(dynamic json) {
    var name = json['name'] as String;
    var desc = json['desc'] as String;

    return Insignia(name, desc);
  }
}
