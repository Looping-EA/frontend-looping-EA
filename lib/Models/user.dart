class User {
  String uname;
  String pswrd;
  String name;
  String email;

  User(this.uname, this.pswrd, this.name, this.email);

  factory User.fromJson(dynamic json) {
    return User(
      json['uname'] as String,
      json['pswrd'] as String,
      json['fullname'] as String,
      json['email'] as String,
    );
  }
}
