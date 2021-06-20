import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:frontend_looping_ea/environment.dart';
import '../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';
import 'package:intl/intl.dart';

class ProjectService{
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

  
  Future<int> createProject(Project project, String uname) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String? token;

    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
      return 1;
    }

    // create JSON object
    final body = {
      "name": project.name,
      "chats": [],
      "creationDate": formattedDate,
      "teams": [],
      "tasks": [],
      "description": project.description,
      "collaboration": [],
      "owner": uname
    };
    final bodyParsed = json.encode(body);
    print(bodyParsed);
    // finally the POST HTTP operation
    return await http
        .post(Uri.parse("http://localhost:8080/api/projects/add"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
            body: bodyParsed)
        .then((http.Response response) {
      if (response.statusCode == 201) {
        return 0;
      } else {
        return 1;
      }
    });
  }
}
