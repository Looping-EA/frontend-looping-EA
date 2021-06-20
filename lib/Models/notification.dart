import '../Models/user.dart';

class Notifictn {
  String message;
  String? user;
  String? project;

  Notifictn(this.message, this.user, this.project);

  factory Notifictn.fromJson(dynamic json) {
    return Notifictn(json['message'], json['user'], json['project']);
  }
}
