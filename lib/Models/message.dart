import '../Models/user.dart';

class Message {
  DateTime date;
  String message;
  List<User> users = [];

  Message(this.date, this.message, this.users);

  factory Message.fromJson(dynamic json) {
    var usersObjsJson = json['members'] as List;
    List<User> _users =
        usersObjsJson.map((memberJson) => User.fromJson(memberJson)).toList();
    return Message(json['date'] as DateTime, json['message'] as String, _users);
  }
}
