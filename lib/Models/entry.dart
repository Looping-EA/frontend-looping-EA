import '../Models/post.dart';

class Entry {
  String name;
  String description;
  List<Post> post = [];

  Entry(this.name, this.description, this.post);

  factory Entry.fromJson(dynamic json) {
    var memberObjsJson = json['members'] as List;
    List<Post> _post =
        memberObjsJson.map((memberJson) => Post.fromJson(memberJson)).toList();
    return Entry(json['name'] as String, json['description'] as String, _post);
  }
}
