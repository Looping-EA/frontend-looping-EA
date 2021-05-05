import '../Models/user.dart';
import '../Models/message.dart';

class Chat {
  String name;
  String description;
  List<User> members = [];
  List<Message> messages = [];

  Chat(this.name, this.description, this.members, this.messages);
}
