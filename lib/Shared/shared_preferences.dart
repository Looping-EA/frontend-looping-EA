import 'package:shared_preferences/shared_preferences.dart';

Future<void> setUsernameToSharedPref(String uname) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('uname', uname);
}

Future<String?> getUsernameFromSharedPref() async {
  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString('uname');
  return username;
}