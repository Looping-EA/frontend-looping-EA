import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';
import 'package:jwt_decode/jwt_decode.dart';

Future<List<Project>> getProjectsAndOwners() async {
  List<Project> projects = [];
  String? token;
  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
  } catch (err) {
    print(err);
  }

  final response = await http
      .get(Uri.parse('http://localhost:8080/api/projects/'), headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json'
  });
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
