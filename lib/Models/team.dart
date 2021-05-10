import '../Models/user.dart';

class Team {
  String name;
  String description;
  List<User> members = [];

  Team(this.name, this.description, this.members);

  factory Team.fromJson(dynamic json) {
    var memberObjsJson = json['members'] as List;
    List<User> _members =
        memberObjsJson.map((memberJson) => User.fromJson(memberJson)).toList();
    return Team(
        json['name'] as String, json['description'] as String, _members);
  }
}
