import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:frontend_looping_ea/environment.dart';

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
    print(response.body);
    User u = User.fromJSONnoPass(json.decode(response.body));
    return u;
  } else
    return new User("", "", "", "", "", "");
}

Future<List<User>> getUsers() async {
  String? token;
  Environment _environment = Environment();

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
    print(response.body);
    var users = json.decode(response.body);
    List<User> usuarios = [];
    try {
      for (var userJson in users) {
        User u = new User(
            userJson["uname"],
            userJson["pswd"],
            userJson["fullname"],
            userJson["email"],
            userJson["aboutMe"],
            userJson["skills"]);
        usuarios.add(u);
      }
    } catch (e) {
      print(e);
    }
    return usuarios;
  } else
    return new List<User>.empty();
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

  print(response.statusCode);
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
  print(bodyParsed);
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
  print(bodyParsed);
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
      return new User("", "", "", "", "", "");
    }
  });
}

Future<User> loginUser(User user) async {
  // create JSON object
  Environment _environment = Environment(); 
  final body = {
    "uname": user.uname,
    "pswd": user.pswrd,
  };
  final bodyParsed = json.encode(body);

  // finally the POST HTTP operation
  return await http
      .post(Uri.parse(_environment.url() + "users/login"),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: bodyParsed)
      .then((http.Response response) async {
    if (response.statusCode == 201) {
      var token = json.decode(response.body);
      await setTokenToSharedPref(token["accessToken"].toString());
      Map<String, dynamic> payload =
          Jwt.parseJwt(token["accessToken"].toString());
      User u = User.grabUnameFromJSON(payload);
      return u;
    } else {
      return new User("", "", "", "", "", "");
    }
  });
}
