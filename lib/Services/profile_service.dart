import '../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';

Future<Map> getUser(uname) async {

  //Cuando metamos las shared preferences cogeremos el uname
  final response = await http.get(
      Uri.parse('http://localhost:8080/api/users/$uname'),
      headers: <String, String>{'Content-Type': 'application/json'});

      Map<String,dynamic> u = jsonDecode(response.body);
      return u;
  


}
