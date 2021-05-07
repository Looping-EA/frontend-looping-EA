import '../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';
import '../Models/project.dart';

Future<List<Project>> getProjects() async {
  List<Project> projects = [];
  final response =
      await http.post(Uri.parse('http://127.0.0.1:8080/api/projects/'));
  if (response.statusCode == 201) {
    var projectsJson = json.decode(response.body);
    for (var projectJson in projectsJson) {
      projects.add(Project.fromJson(projectJson));
    }
  }
  return projects;
}
