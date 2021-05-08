import '../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';
import '../Models/project.dart';

/*Future<List<Project>> getProjects() async {
  //Future<List<Project>> projects = [];
  final response = await http.post(
      Uri.https('https://10.0.2.2:8080/api', '/projects'),
      headers: <String, String>{'Content-Type': 'application/json'});
  if (response.statusCode == 201) {
    var projectsJson = json.decode(response.body);
    print(projectsJson);
    for (var projectJson in projectsJson) {
      // projects.add(Project.fromJson(projectJson));
    }
  }
  //return projects;
}*/

Future<List<Project>> getProjects2() async {
  final response = await http.post(Uri.parse('10.0.2.2:8080/api/projects/'),
      headers: <String, String>{'Content-Type': 'application/json'});
  if (response.statusCode == 201) {
    final jsonData = jsonDecode(response.body);
    print(jsonData);
    throw Exception("todo bien");
  } else {
    throw Exception("pasó algo");
  }
}
