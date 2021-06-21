import 'package:frontend_looping_ea/Models/photo.dart';

import '../Models/user.dart';
import '../Models/chat.dart';
import '../Models/team.dart';
import '../Models/task.dart';
import '../Models/entry.dart';

class Project {
  String name;
  List<Chat> chats = [];
  String creationDate;
  List<Team>? teams = [];
  List<Task>? tasks = [];
  String description;
  List<User>? collaboration = [];
  User owner;
  List<Entry> entry = [];

  Project(this.name, this.chats, this.creationDate, this.teams, this.tasks,
      this.description, this.collaboration, this.owner, this.entry);

  factory Project.fromJsonHereditary(dynamic json) {
    User u = new User("", "", "", "", "", "", [], [], "");
    return Project(json['name'] as String, [], json['creationDate'] as String,
        [], [], json['description'] as String, [], u, []);
  }

  factory Project.fromJson(dynamic json) {
    var chatObjsJson = json['chats'] as List;
    List<Chat> _chats =
        chatObjsJson.map((chatJson) => Chat.fromJson(chatJson)).toList();
    var teamObjsJson = json['teams'] as List;
    List<Team> _teams =
        teamObjsJson.map((teamJson) => Team.fromJson(teamJson)).toList();
    var taskObjsJson = json['tasks'] as List;
    List<Task> _tasks =
        taskObjsJson.map((taskJson) => Task.fromJson(taskJson)).toList();
    var collabObjsJson = json['collaboration'] as List;
    List<User> _collaboration =
        collabObjsJson.map((collabJson) => User.fromJson(collabJson)).toList();
    var entryObjsJson = json['entry'] as List;
    List<Entry> _entry =
        entryObjsJson.map((entryJson) => Entry.fromJson(entryJson)).toList();
    return Project(
        json['name'] as String,
        _chats,
        json['creationDate'] as String,
        _teams,
        _tasks,
        json['description'] as String,
        _collaboration,
        json['owner'] as User,
        _entry);
  }
}
