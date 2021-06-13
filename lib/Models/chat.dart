import '../Models/user.dart';
import '../Models/message.dart';

class Chat {
  String name;
  //String icon;
  bool isGroup;
  String time;
  String currentMessage;
  int id;
  //List<User> members = [];
  //List<Message> messages = [];

  Chat(
    this.name,
    //this.icon,
    this.isGroup,
    this.time,
    this.currentMessage,
    this.id,
  );

  factory Chat.fromJson(dynamic json) {
    //var memberObjsJson = json['members'] as List;
    //List<User> _members =
    //memberObjsJson.map((memberJson) => User.fromJson(memberJson)).toList();
    return Chat(
      json['name'] as String,
      json['isGroup'] as bool,
      json['time'] as String,
      json['currentMessage'] as String,
      json['id'] as int,
    );
  }
}
