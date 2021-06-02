import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/faq.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'package:frontend_looping_ea/Screens/Project/project_screen.dart';
import 'package:frontend_looping_ea/Services/faq_service.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';
import '../../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../styles.dart';
import 'faq_detail.dart';

class FaqsScreen extends StatefulWidget {
  @override
  _FaqsScreenState createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  late Future<List<Faq>> faqs;
  List<Faq> faqslist = [];
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  Widget _appBarTitle = new Text('FAQS');

  _FaqsScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    // try {
    getFaqs().then((result) {
      setState(() {
        faqslist = result;
      });
    });
    // } catch (e) {
    //   print(e);
  }
//}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Faqs", style: Styles.projectText)),
      body: ListView.builder(
        itemCount: this.faqslist.length,
        itemBuilder: _listViewItemBuilder,
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var faq = this.faqslist[index];
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      title: _itemTitle(faq),
      onTap: () {
        _navigationToFaqDetail(context, faq);
      },
    );
  }

  void _navigationToFaqDetail(BuildContext context, Faq faq) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FaqDetail(faq)));
  }

  Widget _itemTitle(Faq faq) {
    return Text('${faq.quest}', style: Styles.projectText);
  }

  PreferredSizeWidget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
    );
  }

  List<Project> getProjectObjects(data) {
    List<Project> projects = [];
    for (var project in data) {
      projects.add(project);
    }
    return projects;
  }
}
