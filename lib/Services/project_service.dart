import '../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';

Future<List<Project>> getProjectsAndOwners() async {
  List<Project> projects = [];
  final response = await http.post(
      Uri.parse('http://localhost:8080/api/projects'),
      headers: <String, String>{'Content-Type': 'application/json'});
  if (response.statusCode == 201) {
    var projectsJson = json.decode(response.body);
    try {
      for (var projectJson in projectsJson) {
        List<User> ownerslist = [];
        for (int i = 0; i < projectJson["owners"].length; i++) {
          User u = new User(projectJson["owners"][i]["uname"], "", "", "");
          ownerslist.add(u);
          print(u.uname);
        }

        print(projectJson["name"]);
        projects.add(Project(
            projectJson["name"],
            [],
            projectJson["creationDate"],
            [],
            [],
            projectJson["description"],
            [],
            ownerslist));
      }
    } catch (e) {
      print(e);
    }
  }

  return projects;
}
