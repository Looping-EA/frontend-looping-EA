import '../Models/user.dart';

class Message {
  DateTime date;
  List<User> users = [];
  String message;

  Message(this.date, this.users, this.message);
}
