import '../Models/project.dart';
import '../Models/notification.dart';

class User {
  String uname;
  String pswrd;
  String fullname;
  String email;
  String? aboutMe;
  String? skills;
  List<Notifictn> notifications;
  List<Project> projectsOwned;
  User(this.uname, this.pswrd, this.fullname, this.email, this.aboutMe,
      this.skills, this.notifications, this.projectsOwned);

  factory User.fromJson(dynamic json) {
    var notifications = json['notifications'] as List;
    List<Notifictn> _notifications =
        notifications.map((notif) => Notifictn.fromJson(notif)).toList();
    var projectsOwned = json['projectsOwned'] as List;
    List<Project> _projectsOwned =
        projectsOwned.map((project) => Project.fromJson(project)).toList();
    return User(
        json['uname'] as String,
        json['pswd'] as String,
        json['fullname'] as String,
        json['email'] as String,
        json['aboutMe'] as String?,
        json['skills'] as String?,
        _notifications,
        _projectsOwned);
  }

  factory User.fromJSONnoPass(dynamic json) {
    return User(
        json['uname'] as String,
        "",
        json['fullname'] as String,
        json['email'] as String,
        json['aboutMe'] as String?,
        json['skills'] as String?, [], []);
  }

  factory User.grabUnameFromJSON(dynamic json) {
    var notifications = json['notifications'] as List;
    List<Notifictn> _notifications =
        notifications.map((notif) => Notifictn.fromJson(notif)).toList();
    var projectsOwned = json['projectsOwned'] as List;
    List<Project> _projectsOwned = projectsOwned
        .map((project) => Project.fromJsonHereditary(project))
        .toList();
    return User(
        json['uname'] as String,
        "",
        json['fullname'] as String,
        json['email'] as String,
        json['aboutMe'] as String?,
        json['skills'] as String?,
        _notifications,
        _projectsOwned);
  }
}
