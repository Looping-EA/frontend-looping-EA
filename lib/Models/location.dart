import '../Models/user.dart';
import '../Models/chat.dart';
import '../Models/team.dart';
import '../Models/task.dart';
import '../Models/project.dart';

class Location {
  String uname;
  String latitude;
  String longitude;

  Location(this.uname, this.latitude, this.longitude);

  factory Location.fromJson(dynamic json) {
    return Location(
        json['uname'] as String,
        json['latitude'] as String,
        json['longitude'] as String,);
  }
}