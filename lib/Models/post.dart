class Post {
  String uname;
  String msg;
  String date;

  Post(this.uname, this.msg, this.date);

  factory Post.fromJson(dynamic json) {
    return Post(
        json['uname'] as String, json['msg'] as String, json['date'] as String);
  }
}
