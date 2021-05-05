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
}
