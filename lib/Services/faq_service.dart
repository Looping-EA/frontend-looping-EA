import '../Models/faq.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend_looping_ea/environment.dart';

class FaqService{
  Future<List<Faq>> getFaqs() async {
    List<Faq> faqs = [];
    Environment _environment = Environment();

    final response = await http.get(Uri.parse(_environment.url() + 'faqs/'),
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
}
