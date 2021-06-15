import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'package:frontend_looping_ea/Screens/Project/project_screen.dart';
import 'package:frontend_looping_ea/Services/project_service.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';
import '../../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../styles.dart';

class FeedProyectos extends StatefulWidget {
  final User user;
  FeedProyectos({Key? key, required this.user}) : super(key: key);

  @override
  _FeedProyectosState createState() => _FeedProyectosState(this.user);
}

class _FeedProyectosState extends State<FeedProyectos> {
  int notifications = 0;
  final User user;
  late Future<List<Project>> projects;
  List<Project> projectNames = [];
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<Project> filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Projects proposed by the community');

  _FeedProyectosState(this.user) {
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
    // try {
    getProjectsAndOwners().then((result) {
      setState(() {
        projectNames = result;
        filteredNames = projectNames;
        notifications = user.notifications.length;
      });
    });
    // } catch (e) {
    //   print(e);
  }
//}

  @override
  Widget build(BuildContext context) {
    print(this.user.uname);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Feed Proyectos',
        home: Scaffold(
            appBar: _buildBar(context),
            drawer: SideMenu(user: this.user),
            body: Container(
              child: _buildList(),
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                    heroTag: "add",
                    child: Icon(Icons.add),
                    onPressed: () {
                      _navigationToCreateProject(context);
                    }),
                FloatingActionButton(
                    heroTag: "search",
                    child: Icon(Icons.search),
                    onPressed: () {
                      _searchPressed();
                    }),
              ],
            )));
  }

  PreferredSizeWidget _buildBar(BuildContext context) {
    return AppBar(centerTitle: true, title: _appBarTitle, actions: <Widget>[
      new Stack(children: <Widget>[
        new IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            setState(() {
              notifications = 0;
              _showDialog();
            });
          },
        ),
        notifications != 0
            ? new Positioned(
                right: 11,
                top: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(minWidth: 14, minHeight: 14),
                  child: Text(
                    '$notifications',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : new Container()
      ])
    ]);
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

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Notifications"),
          content: Container(child: _buildNotifications()),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          subtitle: Text(filteredNames[index].owner.uname),
          onTap: () {
            _navigationToProject(context, filteredNames[index], user);
          },
        );
      },
    );
  }

  Widget _buildNotifications() {
    return Container(
        height: 300.0,
        width: 300.0,
        child: ListView.builder(
            itemCount: user.notifications.length,
            itemBuilder: (BuildContext context, int index) {
              return new ListTile(
                title: Text(user.notifications[index]),
                onTap: () {},
              );
            }));
  }

  List<Project> getProjectObjects(data) {
    List<Project> projects = [];
    for (var project in data) {
      projects.add(project);
    }
    return projects;
  }

  // Al clicar en un proyecto entrar en el
  void _navigationToProject(BuildContext context, Project project, User user) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProjectScreen(project, user)));
  }

  void _navigationToCreateProject(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateProjectScreen(user: this.user)));
  }

  /* String ownersNameStringBuilder(Project x) {
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
  }*/
}
