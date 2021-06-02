import 'package:frontend_looping_ea/Models/insignia.dart';

class User {
  String uname;
  String pswrd;
  String fullname;
  String email;
  List<Insignia> insignias = [];

  User(this.uname, this.pswrd, this.fullname, this.email, this.insignias);

  factory User.fromJson(dynamic json) {
    var insigniasObjJson = json['insignias'] as List;
    List<Insignia> _insignia = insigniasObjJson
        .map((insigniaJson) => Insignia.fromJson(insigniaJson))
        .toList();

    return User(json['uname'] as String, json['pswd'] as String,
        json['fullname'] as String, json['email'] as String, _insignia);
  }

  factory User.fromJSONnoPass(dynamic json) {
    var insigniasObjJson = json['insignias'] as List;
    List<Insignia> _insignia = insigniasObjJson
        .map((insigniaJson) => Insignia.fromJson(insigniaJson))
        .toList();

    return User(json['uname'] as String, "", json['fullname'] as String,
        json['email'] as String, _insignia);
  }

  factory User.grabUnameFromJSON(dynamic json) {
    print("grabbing " + json['insignias'].toString());
    var insigniasObjJson = json['insignias'] as List;
    List<Insignia> _insignia = insigniasObjJson.map((insigniaJson) {
      print(insigniaJson);
      return Insignia.fromJson(insigniaJson);
    }).toList();

    print("aaaaaa");
    return User(json['uname'] as String, "", json['fullname'], json['email'],
        _insignia);
  }
}
