import 'package:shared_preferences/shared_preferences.dart';

Future<void> setUsernameToSharedPref(String uname) async {
  print("setting username $uname");
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('uname', uname);
}

Future<String?> getUsernameFromSharedPref() async {
  final prefs = await SharedPreferences.getInstance();
  final username = await prefs.getString('uname');
  return username;
}

Future<void> setCandidateUsernameToSharedPref(String uname) async {
  print("setting candidate $uname");
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('candidate', uname);
}

Future<String?> getCandidateUsernameFromSharedPref() async {
  final prefs = await SharedPreferences.getInstance();
  final candidate = await prefs.getString('candidate');
  return candidate;
}

Future<void> setTokenToSharedPref(String token) async {
  print("setting token $token");
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

Future<String?> getTokenFromSharedPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  return token;
}
