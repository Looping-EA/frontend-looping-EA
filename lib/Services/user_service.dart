import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:frontend_looping_ea/Shared/shared_preferences.dart';

Future<User> getUser(uname) async {
  String? token;
  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
  } catch (err) {
    print(err);
  }
  print("getting user $uname");
  //Cuando metamos las shared preferences cogeremos el uname
  final response = await http
      .get(Uri.parse('http://localhost:8080/api/users/$uname'), headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  });
  if (response.statusCode == 200) {
    print(response.body);
    User u = User.grabUnameFromJSON(json.decode(response.body));
    return u;
  } else
    return new User("", "", "", "", "", "", [], []);
}

Future<int> deleteNotif(String user, String notification) async {
  String? token;
  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
  } catch (err) {
    print(err);
  }
  final body = {"notification": notification, "user": user};
  final bodyParsed = json.encode(body);
  print(bodyParsed);
  final response = await http.delete(
      Uri.parse('http://localhost:8080/api/notification/delete'),
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

Future<int> getUsers() async {
  String? token;
  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
  } catch (err) {
    print(err);
  }
  print("getting users");
  final response = await http.get(Uri.parse('http://localhost:8080/api/users/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
  if (response.statusCode == 201) {
    print(response.body);
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
  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
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
      Uri.parse('http://localhost:8080/api/users/delete'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: bodyParsed);

  print(response.statusCode);
  if (response.statusCode == 201) {
    return exito;
  } else
    return fail;
}

Future<int> updateAboutMe(String uname, String aboutMe) async {
  String? token;
  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
  } catch (err) {
    print(err);
  }
  final body = {
    "uname": uname,
    "aboutMe": aboutMe,
  };
  final bodyParsed = json.encode(body);
  print(bodyParsed);
  final response = await http.post(
      Uri.parse('http://localhost:8080/api/users/updateAboutMe'),
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
  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
  } catch (err) {
    print(err);
  }
  final body = {
    "uname": uname,
    "skills": skills,
  };
  final bodyParsed = json.encode(body);
  print(bodyParsed);
  final response = await http.post(
      Uri.parse('http://localhost:8080/api/users/updateSkills'),
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
  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
  } catch (err) {
    print(err);
  }
  final body = {
    "uname": uname,
    "projects": projects,
  };
  final bodyParsed = json.encode(body);
  print(bodyParsed);
  final response = await http.post(
      Uri.parse('http://localhost:8080/api/users/updateProjects'),
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
  final body = {
    "uname": user.uname,
    "pswd": user.pswrd,
    "email": user.email,
    "fullname": user.fullname
  };
  final bodyParsed = json.encode(body);

  // finally the POST HTTP operation
  return await http
      .post(Uri.parse("http://localhost:8080/api/users/register"),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: bodyParsed)
      .then((http.Response response) async {
    if (response.statusCode == 201) {
      print(response.body);
      var token = json.decode(response.body);
      print(token["accessToken"].toString());
      await setTokenToSharedPref(token["accessToken"].toString());
      Map<String, dynamic> payload =
          Jwt.parseJwt(token["accessToken"].toString());
      User u = User.fromJson(payload);
      return u;
    } else {
      return new User("", "", "", "", "", "", [], []);
    }
  });
}

Future<User> loginUser(User user) async {
  // create JSON object
  final body = {
    "uname": user.uname,
    "pswd": user.pswrd,
  };
  final bodyParsed = json.encode(body);
  print(bodyParsed);

  // finally the POST HTTP operation
  final response = await http.post(
      Uri.parse("http://localhost:8080/api/users/login"),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: bodyParsed);
  if (response.statusCode == 201) {
    var token = json.decode(response.body);
    print(token["accessToken"].toString());
    await setTokenToSharedPref(token["accessToken"].toString());
    Map<String, dynamic> payload =
        Jwt.parseJwt(token["accessToken"].toString());
    print(payload);
    User u = User.grabUnameFromJSON(payload);
    return u;
  } else {
    return new User("", "", "", "", "", "", [], []);
  }
}
