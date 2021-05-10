import '../Models/user.dart';

class Task {
  String name;
  String description;
  String status;
  List<User> members = [];
  DateTime dateInitial;
  DateTime dateFinal;

  Task(this.name, this.description, this.status, this.members, this.dateInitial,
      this.dateFinal);

  factory Task.fromJson(dynamic json) {
    var memberObjsJson = json['members'] as List;
    List<User> _members =
        memberObjsJson.map((memberJson) => User.fromJson(memberJson)).toList();
    return Task(
        json['name'] as String,
        json['description'] as String,
        json['status'] as String,
        _members,
        json['dateInitial'] as DateTime,
        json['dateFinal'] as DateTime);
  }
}
