import '../Models/user.dart';
import '../Models/message.dart';

class Chat {
  String name;
  String description;
  List<User> members = [];
  //List<Message> messages = [];

  Chat(
    this.name,
    this.description,
    this.members,
  );

  factory Chat.fromJson(dynamic json) {
    var memberObjsJson = json['members'] as List;
    List<User> _members =
        memberObjsJson.map((memberJson) => User.fromJson(memberJson)).toList();
    return Chat(
        json['name'] as String, json['description'] as String, _members);
  }
}
