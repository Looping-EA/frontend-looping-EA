class Contacto {
  String uname;
  String date;
  String message;

  Contacto(this.uname, this.date, this.message);

  factory Contacto.fromJson(dynamic json) {
    return Contacto(
      json['uname'] as String,
      json['date'] as String,
      json['message'] as String,
    );
  }
}
