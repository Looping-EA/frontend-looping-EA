import '../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';
import '../Models/project.dart';

Future<List<Project>> getProjectsAndOwners() async {
  List<Project> projects = [];
  final response = await http.post(
      Uri.parse('http://localhost:8080/api/projects'),
      headers: <String, String>{'Content-Type': 'application/json'});
  if (response.statusCode == 201) {
    var projectsJson = json.decode(response.body);
    print(projectsJson);
    for (var projectJson in projectsJson) {
      print("va bien");
      List<User> ownerslist = [];
      for (int i = 0; i < projectJson["owners"].length; i++) {
        User u = new User(projectJson["owners"][i]["uname"], "", "", "");
        ownerslist.add(u);
        print(u.uname);
      }

      print("vabien2");
      print(projectJson["name"]);
      projects.add(
          Project(projectJson["name"], [], "", [], [], "", [], ownerslist));
    }
  }
  print(projects[0].name);
  return projects;
}

Future<List<Project>> getProjects2() async {
  final response = await http.post(
      Uri.parse('http://localhost:8080/api/projects/'),
      headers: <String, String>{'Content-Type': 'application/json'});
  if (response.statusCode == 201) {
    final jsonData = jsonDecode(response.body);
    print(jsonData);
    throw Exception("todo bien");
  } else {
    throw Exception("pasó algo");
  }
}
