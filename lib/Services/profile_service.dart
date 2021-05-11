import '../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';

Future<Map> getUser(uname) async {
  //Cuando metamos las shared preferences cogeremos el uname
  final response = await http.get(
      Uri.parse('http://localhost:8080/api/users/$uname'),
      headers: <String, String>{'Content-Type': 'application/json'});

  Map<String, dynamic> u = jsonDecode(response.body);
  return u;
}

Future<String> deleteUser(uname) async {
  String exito = "deleted";
  String fail = "failed";
  json.encode(uname);
  final response = await http.post(
      Uri.parse('http://localhost:8080/api/delete'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: uname);
  if (response.statusCode == 201) {
    return exito;
  } else
    return fail;
}
