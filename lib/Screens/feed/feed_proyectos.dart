import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'package:frontend_looping_ea/Screens/Project/project_screen.dart';
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
  late Future<List<Project>> projects;
  List<Project> projectNames = [];
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<Project> filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Projects proposed by the community');

  _FeedProyectosState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = projectNames;
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
    try {
      getProjectsAndOwners().then((result) {
        setState(() {
          projectNames = result;
          filteredNames = projectNames;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Feed Proyectos',
        home: Scaffold(
          appBar: _buildBar(context),
          body: Container(
            child: _buildList(),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _navigationToCreateProject(context);
            },
          ),
        ));
  }

  PreferredSizeWidget _buildBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: _appBarTitle,
        leading: new IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,
        ));
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
            controller: _filter,
            decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.search),
                hintText: 'Search projects...'));
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Projects proposed by the community');
        filteredNames = projectNames;
        _filter.clear();
      }
    });
  }

  Widget _buildList() {
    if ((_searchText.isNotEmpty)) {
      List<Project> tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .name
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: projectNames == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index].name),
          subtitle: Text(ownersNameStringBuilder(filteredNames[index])),
          onTap: () {
            _navigationToProject(context, filteredNames[index]);
          },
        );
      },
    );
  }

  List<Project> getProjectObjects(data) {
    List<Project> projects = [];
    for (var project in data) {
      projects.add(project);
    }
    return projects;
  }

  // Al clicar en un proyecto entrar en el
  void _navigationToProject(BuildContext context, Project project) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProjectScreen(project)));
  }

  void _navigationToCreateProject(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateProjectScreen()));
  }

  String ownersNameStringBuilder(Project x) {
    //Builds a string with owners' names
    if (x.owners.length != 0) {
      String names = x.owners[0].uname;
      if (x.owners.length > 1) {
        for (int i = 0; i < x.owners.length; i++) {
          names = names + ", " + x.owners[i].uname;
        }
      }
      return names;
    } else {
      return "";
    }
  }
}
