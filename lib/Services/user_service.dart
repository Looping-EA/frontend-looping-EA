import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:frontend_looping_ea/environment.dart';
import 'package:frontend_looping_ea/Models/project.dart';
import 'dart:core';

class UserService {
  Future<User> getUser(uname) async {
    String? token;
    Environment _environment = Environment();

    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
    }
    print("getting user $uname");
    //Cuando metamos las shared preferences cogeremos el uname
    final response = await http
        .get(Uri.parse(_environment.url() + 'users/$uname'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      User u = User.grabUnameFromJSON(json.decode(response.body));
      return u;
    } else
      return new User("", "", "", "", "", "", [], [], [], "");
  }

  Future<int> getUsers() async {
    String? token;
    Environment _environment = Environment();

    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
    }
    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
    }
    print("getting users");
    final response = await http.get(Uri.parse(_environment.url() + 'users/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 201) {
      var users = json.decode(response.body);
      int cont = 0;
      try {
        for (var userJson in users) {
          cont++;
        }
      } catch (e) {
        print(e);
      }
      return cont;
    } else
      return 0;
  }

  Future<String> deleteUser(uname) async {
    String? token;
    Environment _environment = Environment();

    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
    }
    String exito = "deleted";
    String fail = "failed";
    final body = {
      "uname": uname,
    };
    final bodyParsed = json.encode(body);
    final response = await http.post(
        Uri.parse(_environment.url() + 'users/delete'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: bodyParsed);

    if (response.statusCode == 201) {
      return exito;
    } else
      return fail;
  }

  Future<int> updateAboutMe(String uname, String aboutMe) async {
    String? token;
    Environment _environment = Environment();

    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
    }
    final body = {
      "uname": uname,
      "aboutMe": aboutMe,
    };
    final bodyParsed = json.encode(body);
    final response = await http.post(
        Uri.parse(_environment.url() + 'users/updateAboutMe'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: bodyParsed);
    if (response.statusCode == 201) {
      return 0;
    } else
      return 1;
  }

  Future<int> recommendUser(String uname, String userRecommended) async {
    String? token;
    Environment _environment = Environment();
    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
    }
    final body = {"user": uname, "userRecommended": userRecommended};
    final bodyParsed = json.encode(body);
    print(bodyParsed);
    final response = await http.post(
        Uri.parse(_environment.url() + 'users/recommend'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: bodyParsed);
    if (response.statusCode == 201) {
      return 0;
    } else
      return 1;
  }

  Future<int> deleteNotif(String user, String notification) async {
    String? token;
    Environment _environment = Environment();

    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
      print(token);
    } catch (err) {
      print(err);
    }
    final body = {"notification": notification, "user": user};
    final bodyParsed = json.encode(body);
    final response = await http.delete(
        Uri.parse(_environment.url() + 'notification/delete'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: bodyParsed);
    if (response.statusCode == 201) {
      return 0;
    } else
      return 1;
  }

  Future<int> updatePhoto(String user, String url) async {
    String? token;
    Environment _environment = Environment();
    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
    }
    final body = {"user": user, "imagePath": url};
    final bodyParsed = json.encode(body);
    final response = await http.post(
        Uri.parse(_environment.url() + 'photo/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: bodyParsed);
    if (response.statusCode == 201) {
      return 0;
    } else
      return 1;
  }

  Future<int> updateSkills(String uname, String skills) async {
    String? token;
    Environment _environment = Environment();

    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
    }
    final body = {
      "uname": uname,
      "skills": skills,
    };
    final bodyParsed = json.encode(body);
    final response = await http.post(
        Uri.parse(_environment.url() + 'users/updateSkills'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: bodyParsed);
    if (response.statusCode == 201) {
      return 0;
    } else
      return 1;
  }

  Future<int> updateProjects(String uname, String projects) async {
    String? token;
    Environment _environment = Environment();
    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
    }
    final body = {
      "uname": uname,
      "projects": projects,
    };
    final bodyParsed = json.encode(body);
    final response = await http.post(
        Uri.parse(_environment.url() + 'users/updateProjects'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: bodyParsed);
    if (response.statusCode == 201) {
      return 0;
    } else
      return 1;
  }

  Future<User> registerUser(User user) async {
    // create JSON object
    Environment _environment = Environment();
    final body = {
      "uname": user.uname,
      "pswd": user.pswrd,
      "email": user.email,
      "fullname": user.fullname
    };
    final bodyParsed = json.encode(body);

    // finally the POST HTTP operation
    return await http
        .post(Uri.parse(_environment.url() + "users/register"),
            headers: <String, String>{'Content-Type': 'application/json'},
            body: bodyParsed)
        .then((http.Response response) async {
      if (response.statusCode == 201) {
        var token = json.decode(response.body);
        await setTokenToSharedPref(token["accessToken"].toString());
        Map<String, dynamic> payload =
            Jwt.parseJwt(token["accessToken"].toString());
        User u = User.fromJson(payload);
        return u;
      } else {
        return new User("", "", "", "", "", "", [], [], [], "");
      }
    });
  }

  Future<User> loginUser(User user) async {
    Environment _environment = Environment();
    // create JSON object
    final body = {
      "uname": user.uname,
      "pswd": user.pswrd,
    };
    final bodyParsed = json.encode(body);

    // finally the POST HTTP operation
    final response = await http.post(
        Uri.parse(_environment.url() + "users/login"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: bodyParsed);
    if (response.statusCode == 201) {
      var token = json.decode(response.body);
      await setTokenToSharedPref(token["accessToken"].toString());
      Map<String, dynamic> payload =
          Jwt.parseJwt(token["accessToken"].toString());
      User u = User.grabUnameFromJSON(payload);
      return u;
    } else {
      return new User("", "", "", "", "", "", [], [], [], "");
    }
  }

  Future<List<Project>> getUserProject(String uname) async {
    String? token;
    Environment _environment = Environment();
    List<Project> _projects = [];
    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
    }
    final response = await http.get(
        Uri.parse(_environment.url() + "users/$uname/getProjects"),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
        );
    if(response.statusCode == 200){
      var projectsJson = json.decode(response.body);
      try{
        for (var projectJson in projectsJson){
         Project project = Project.fromJson(projectJson);
         _projects.add(project);
        }
      } catch (e) {
        print(e);
        return [];
      }
      return _projects;
    } else {
      return [];
    }
  }
}
