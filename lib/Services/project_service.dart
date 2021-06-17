import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:frontend_looping_ea/environment.dart';
import '../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';

Future<List<Project>> getProjectsAndOwners() async {
  List<Project> projects = [];
  String? token;
  Environment _environment = Environment();

  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
    print("token printed above");
  } catch (err) {
    print(err);
  }

  final response = await http
      .get(Uri.parse(_environment.url() + 'projects/'), headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json'
  });
  if (response.statusCode == 201) {
    var projectsJson = json.decode(response.body);
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
