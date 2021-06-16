import 'package:frontend_looping_ea/Shared/shared_preferences.dart';

import '../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';

Future<List<Project>> getProjectsAndOwners() async {
  List<Project> projects = [];
  String? token;
  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
    print("token printed above");
  } catch (err) {
    print(err);
  }

  final response = await http
      .get(Uri.parse('http://backend:8080/api/projects/'), headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json'
  });
  if (response.statusCode == 201) {
    var projectsJson = json.decode(response.body);
    print(response.body + " proyectosrsfbaegdb");
    try {
      for (var projectJson in projectsJson) {
        User owner = User.fromJSONnoPass(projectJson["owner"]);
        print(projectJson["name"]);
        projects.add(Project(
            projectJson["name"],
            [],
            projectJson["creationDate"],
            [],
            [],
            projectJson["description"],
            [],
            owner));
      }
    } catch (e) {
      print(e);
    }
  }

  return projects;
}
