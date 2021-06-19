import '../Models/user.dart';

class Message {
  String type;
  String text;
  String time;
  Message(this.type, this.text, this.time);

  factory Message.fromJson(dynamic json) {
    return Message(
        json['type'] as String, json['text'] as String, json['time'] as String);
  }
}
