import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Services/project_service.dart';
import '../../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(FeedProyectos());

class FeedProyectos extends StatefulWidget {
  @override
  _FeedProyectosState createState() => _FeedProyectosState();
}

class _FeedProyectosState extends State<FeedProyectos> {
  List<Project> projects = [];
  @override
  void initState() {
    super.initState();
    projects = getProjects() as List<Project>;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feed Proyectos',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Proyectos'),
        ),
        body: ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(projects[index].name),
                subtitle: Text(
                  ownersNameStringBuilder(projects[index]),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              );
            }),
      ),
    );
  }

  String ownersNameStringBuilder(Project x) {
    //Builds a string with owners' names
    String names = x.owners[0].uname;
    if (x.owners.length > 1) {
      for (int i = 0; i < x.owners.length; i++) {
        names = names + ", " + x.owners[i].uname;
      }
    }
    return names;
  }
}
