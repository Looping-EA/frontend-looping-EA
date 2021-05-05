import '../Models/user.dart';
import '../Models/chat.dart';
import '../Models/team.dart';
import '../Models/task.dart';

class Project {
  String name;
  List<Chat> chats = [];
  DateTime creationDate;
  List<Team> teams = [];
  List<Task> tasks = [];
  String description;
  List<User> collaboration = [];
  List<User> owners = [];

  Project(this.name, this.chats, this.creationDate, this.teams, this.tasks,
      this.description, this.collaboration, this.owners);
}
