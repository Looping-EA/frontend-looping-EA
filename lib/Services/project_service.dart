import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';
import 'package:jwt_decode/jwt_decode.dart';

Future<int> applyToProject(Project p, User u, User owner) async {
  String? token;
  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
    print("token printed above");
  } catch (err) {
    print(err);
  }
  final body = {
    "uname": u.uname,
    "owner": owner.uname,
    "projectName": p.name,
  };
  final bodyParsed = json.encode(body);
  print(bodyParsed);
  final response = await http.post(
      Uri.parse('http://localhost:8080/api/projects/apply'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: bodyParsed);
  if (response.statusCode == 201) {
    return 0;
  }
  if (response.statusCode == 409) {
    return 2;
  }
  if (response.statusCode == 204) {
    return 3;
  } else
    return 1;
}

Future<int> acceptRequest(
    String? project, String? userAccepted, String uname) async {
  String? token;
  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
    print("token printed above");
  } catch (err) {
    print(err);
  }
  final body = {
    "projectName": project,
    "userAccepted": userAccepted,
    "uname": uname,
  };
  final bodyParsed = json.encode(body);
  print(bodyParsed);
  final response = await http.post(
      Uri.parse('http://localhost:8080/api/projects/acceptMember'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: bodyParsed);
  if (response.statusCode == 201) {
    return 0;
  }
  if (response.statusCode == 409) {
    return 2;
  }
  if (response.statusCode == 204) {
    return 3;
  } else
    return 1;
}

Future<int> rejectRequest(
    String? project, String? userRejected, String uname) async {
  String? token;
  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
    print("token printed above");
  } catch (err) {
    print(err);
  }
  final body = {
    "projectName": project,
    "userRejected": userRejected,
    "uname": uname,
  };
  final bodyParsed = json.encode(body);
  print(bodyParsed);
  final response = await http.post(
      Uri.parse('http://localhost:8080/api/projects/rejectMember'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: bodyParsed);
  if (response.statusCode == 201) {
    return 0;
  }
  if (response.statusCode == 409) {
    return 2;
  }
  if (response.statusCode == 204) {
    return 3;
  } else
    return 1;
}

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
      .get(Uri.parse('http://localhost:8080/api/projects/'), headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json'
  });
  if (response.statusCode == 201) {
    var projectsJson = json.decode(response.body);
    print(response.body + " proyectosrsfbaegdb");
    try {
      for (var projectJson in projectsJson) {
        User owner = User.fromJSONnoPass(projectJson['owner']);
        var collabObjsJson = projectJson['collaboration'] as List;
        List<User> _collaboration = collabObjsJson
            .map((collabJson) => User.fromJSONnoPass(collabJson))
            .toList();
        print(projectJson['name']);
        projects.add(Project(
            projectJson['name'],
            [],
            projectJson['creationDate'],
            [],
            [],
            projectJson['description'],
            _collaboration,
            owner));
      }
    } catch (e) {
      print(e);
    }
  }

  return projects;
}
