import '../Models/user.dart';
import '../Models/chat.dart';
import '../Models/team.dart';
import '../Models/task.dart';
import '../Models/project.dart';

class Contacto {
  String uname;
  String date;
  String message;

  Contacto(this.uname, this.date, this.message);

  factory Contacto.fromJson(dynamic json) {
    return Contacto(
        json['uname'] as String,
        json['date'] as String,
        json['message'] as String,);
  }
}