import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';

Future<User> getUser(uname) async {
  print("getting user $uname");
  //Cuando metamos las shared preferences cogeremos el uname
  final response = await http.get(
      Uri.parse('http://localhost:8080/api/users/$uname'),
      headers: <String, String>{'Content-Type': 'application/json'});
  if (response.statusCode == 200) {
    print(response.body);
    User u = User.fromJSONnoPass(json.decode(response.body));
    return u;
  } else
    return new User("", "", "", "");
}

Future<String> deleteUser(uname) async {
  String exito = "deleted";
  String fail = "failed";
  final body = {
    "uname": uname,
  };
  final bodyParsed = json.encode(body);
  final response = await http.post(
      Uri.parse('http://localhost:8080/api/users/delete'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: bodyParsed);

  print(response.statusCode);
  if (response.statusCode == 201) {
    return exito;
  } else
    return fail;
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
      .then((http.Response response) {
    if (response.statusCode == 201) {
      print(response.body);
      User u = User.fromJson(json.decode(response.body));
      return u;
    } else {
      return new User("", "", "", "");
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
  return await http
      .post(Uri.parse("http://backend:8080/api/users/login"),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: bodyParsed)
      .then((http.Response response) {
    print("asdasdasdasd");
    if (response.statusCode == 201) {
      print(response.body);
      User u = User.grabUnameFromJSON(json.decode(response.body));
      return u;
    } else {
      return new User("", "", "", "");
    }
  });
}
