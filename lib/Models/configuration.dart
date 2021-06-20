class Configuration {
  String uname;
  String notificaciones;
  String seguridad;
  String privacidad;

  Configuration(
      this.uname, this.notificaciones, this.seguridad, this.privacidad);

  factory Configuration.fromJson(dynamic json) {
    return Configuration(
        json['uname'] as String,
        json['notificaciones'] as String,
        json['seguridad'] as String,
        json['privacidad'] as String);
  }
}
