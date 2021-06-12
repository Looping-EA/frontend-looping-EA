import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/faq.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/user.dart';
import 'package:jwt_decode/jwt_decode.dart';

Future<List<Faq>> getFaqs() async {
  List<Faq> faqs = [];

  final response = await http.get(Uri.parse('http://localhost:8080/api/faqs/'),
      headers: {'Content-Type': 'application/json'});
  if (response.statusCode == 201) {
    var faqsJson = json.decode(response.body);
    try {
      for (var faqJson in faqsJson) {
        print(faqJson["quest"]);
        faqs.add(Faq(faqJson["quest"], faqJson["resp"]));
      }
    } catch (e) {
      print(e);
    }
  }

  return faqs;
}
