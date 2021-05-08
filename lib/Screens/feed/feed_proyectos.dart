import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Services/project_service.dart';
import '../../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../styles.dart';

void main() => runApp(FeedProyectos());

class FeedProyectos extends StatefulWidget {
  @override
  _FeedProyectosState createState() => _FeedProyectosState();
}

class _FeedProyectosState extends State<FeedProyectos> {
  //Future<List<Project>> projects;
  @override
  void initState() {
    super.initState();
    getProjects2();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feed Proyectos',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Proyectos', style: Styles.subtitle),
          ),
          body: FutureBuilder(
              // future: projects,
              builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: listProjects(snapshot.data),
              );
            } else if (snapshot.hasError) {
              return Text("No hay proyectos");
            }
            return Center(child: CircularProgressIndicator());
          })),
      // Al clicar en un proyecto entrar en el, como no hay pagina de proyecto todavia no esta operativa
      //void _navigationToProjectDetail(BuildContext context, Project project) {
      //Navigator.push(context,
      //MaterialPageRoute(builder: (context) => ProjectDetail(project)));
      //}
    );
  }

  List<Widget> listProjects(data) {
    List<Widget> projects = [];
    for (var project in data) {
      projects.add(
        ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(project.name),
                subtitle: Text(
                  ownersNameStringBuilder(project),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              );
            }),
      );
    }
    return projects;
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
