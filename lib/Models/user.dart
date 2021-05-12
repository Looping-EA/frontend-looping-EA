class User {
  String uname;
  String pswrd;
  String fullname;
  String email;

  User(this.uname, this.pswrd, this.fullname, this.email);

  factory User.fromJson(dynamic json) {
    return User(
      json['uname'] as String,
      json['pswd'] as String,
      json['fullname'] as String,
      json['email'] as String,
    );
  }

  factory User.fromJSONnoPass(dynamic json) {
    return User(
      json['uname'] as String,
      "",
      json['fullname'] as String,
      json['email'] as String,
    );
  }

  factory User.grabUnameFromJSON(dynamic json) {
    return User(json['uname'] as String, "", json['fullname'], json['email']);
  }
}
