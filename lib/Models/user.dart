class User {
  String uname;
  String pswrd;
  String fullname;
  String email;
  String? aboutMe;

  User(this.uname, this.pswrd, this.fullname, this.email, this.aboutMe);

  factory User.fromJson(dynamic json) {
    return User(
        json['uname'] as String,
        json['pswd'] as String,
        json['fullname'] as String,
        json['email'] as String,
        json['aboutMe'] as String?);
  }

  factory User.fromJSONnoPass(dynamic json) {
    return User(json['uname'] as String, "", json['fullname'] as String,
        json['email'] as String, json['aboutMe'] as String?);
  }

  factory User.grabUnameFromJSON(dynamic json) {
    return User(json['uname'] as String, "", json['fullname'], json['email'],
        json['aboutMe'] as String?);
  }
}
