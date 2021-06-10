import '../Models/project.dart';

class User {
  String uname;
  String pswrd;
  String fullname;
  String email;
  String? aboutMe;
  String? skills;

  User(this.uname, this.pswrd, this.fullname, this.email, this.aboutMe,
      this.skills);

  factory User.fromJson(dynamic json) {
    var projectsOwnedObjsJson = json['projectsOwned'] as List;
    List<Project> _projectsOwned = projectsOwnedObjsJson
        .map((projectsOwnedJson) => Project.fromJson(projectsOwnedJson))
        .toList();
    return User(
      json['uname'] as String,
      json['pswd'] as String,
      json['fullname'] as String,
      json['email'] as String,
      json['aboutMe'] as String?,
      json['skills'] as String?,
    );
  }

  factory User.fromJSONnoPass(dynamic json) {
    return User(
      json['uname'] as String,
      "",
      json['fullname'] as String,
      json['email'] as String,
      json['aboutMe'] as String?,
      json['skills'] as String?,
    );
  }

  factory User.grabUnameFromJSON(dynamic json) {
    var projectsOwnedObjsJson = json['projectsOwned'] as List;
    List<Project> _projectsOwned = projectsOwnedObjsJson
        .map((projectsOwnedJson) => Project.fromJson(projectsOwnedJson))
        .toList();
    return User(json['uname'] as String, "", json['fullname'], json['email'],
        json['aboutMe'] as String?, json['skills'] as String?);
  }
}
