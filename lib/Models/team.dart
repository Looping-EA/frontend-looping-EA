import '../Models/user.dart';

class Team {
  String name;
  String description;
  List<User> members = [];

  Team(this.name, this.description, this.members);
}
