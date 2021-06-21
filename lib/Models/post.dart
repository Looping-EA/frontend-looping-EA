class Post {
  String uname;
  String mensaje;
  String date;

  Post(this.uname, this.mensaje, this.date);

  factory Post.fromJson(dynamic json) {
    return Post(json['uname'] as String, json['mensaje'] as String,
        json['date'] as String);
  }
}
