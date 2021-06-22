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
  List<User> recomendations;
  String? photo;

  User(
      this.uname,
      this.pswrd,
      this.fullname,
      this.email,
      this.aboutMe,
      this.skills,
      this.notifications,
      this.projectsOwned,
      this.recomendations,
      this.photo);

  factory User.fromJson(dynamic json) {
    var notifications = json['notifications'] as List;
    List<Notifictn> _notifications =
        notifications.map((notif) => Notifictn.fromJson(notif)).toList();
    var projectsOwned = json['projectsOwned'] as List;
    List<Project> _projectsOwned = projectsOwned
        .map((project) => Project.fromJsonHereditary(project))
        .toList();
    var recomendations = json['recomendations'] as List;
    List<User> _recomendations =
        recomendations.map((user) => User.fromJSONnoPass(user)).toList();
    return User(
        json['uname'] as String,
        json['pswd'] as String,
        json['fullname'] as String,
        json['email'] as String,
        json['aboutMe'] as String?,
        json['skills'] as String?,
        _notifications,
        _projectsOwned,
        _recomendations,
        json['photo'] as String?);
  }

  factory User.fromJSONnoPass(dynamic json) {
    print('*** JSON object for User');
    print(json);
    return User(
        json['uname'] as String,
        "",
        json['fullname'] as String,
        json['email'] as String,
        json['aboutMe'] as String?,
        json['skills'] as String?,
        [],
        [],
        [],
        "");
  }

  factory User.grabUnameFromJSON(dynamic json) {
    var notifications = json['notifications'] as List;
    List<Notifictn> _notifications =
        notifications.map((notif) => Notifictn.fromJson(notif)).toList();
    var projectsOwned = json['projectsOwned'] as List;
    List<Project> _projectsOwned = projectsOwned
        .map((project) => Project.fromJsonHereditary(project))
        .toList();
    var recomendations = json['recomendations'] as List;
    List<User> _recomendations =
        recomendations.map((user) => User.fromJSONnoPass(user)).toList();
    return User(
        json['uname'] as String,
        "",
        json['fullname'] as String,
        json['email'] as String,
        json['aboutMe'] as String?,
        json['skills'] as String?,
        _notifications,
        _projectsOwned,
        _recomendations,
        json['photo'] as String?);
  }
}
