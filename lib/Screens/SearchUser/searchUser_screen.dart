import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/notification.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'package:frontend_looping_ea/Screens/ProfileView/profileView_screen.dart';
import 'package:frontend_looping_ea/Screens/Project/project_screen.dart';
import 'package:frontend_looping_ea/Services/project_service.dart';
import 'package:frontend_looping_ea/Services/user_service.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';
import '../../Models/project.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:frontend_looping_ea/Screens/Notifications/notifications_screen.dart';
import 'dart:convert';
import '../../styles.dart';

class SearchUsers extends StatefulWidget {
  final User user;
  SearchUsers({Key? key, required this.user}) : super(key: key);

  @override
  _SearchUsersState createState() => _SearchUsersState(this.user);
}

class _SearchUsersState extends State<SearchUsers> {
  int notifications = 0;
  final User user;
  late Future<List<User>> users;
  List<User> projectNames = [];
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<User> filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Projects proposed by the community');
  UserService userService = new UserService();

  ProjectService projectService = new ProjectService();

  _SearchUsersState(this.user) {
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
    userService.getUsersObjects().then((result) {
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
                    backgroundColor: Colors.blueGrey,
                    onPressed: () {
                      _navigationToCreateProject(context);
                    }),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: FloatingActionButton(
                      heroTag: "search",
                      child: Icon(Icons.search),
                      onPressed: () {
                        _searchPressed();
                      }),
                ),
              ],
            )));
  }

  PreferredSizeWidget _buildBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: _appBarTitle,
        actions: <Widget>[
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
        this._searchIcon = new Icon(Icons.close, color: Colors.white);
        this._appBarTitle = new TextField(
            controller: _filter,
            style: TextStyle(color: Colors.white),
            decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.search, color: Colors.white),
                hintText: 'Search projects...'));
      } else {
        this._searchIcon = new Icon(Icons.search, color: Colors.white);
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
            new Text("Tap a notification to interact or delete it"),
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
      List<User> tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .uname
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
          title: Text(filteredNames[index].uname),
          subtitle: Text(filteredNames[index].fullname),
          onTap: () {
            _navigationToUser(context, user, filteredNames[index].uname);
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
                title: Text(user.notifications[index].message),
                onTap: () {
                  _navigationToNotification(
                      context, user, user.notifications[index]);
                },
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
  void _navigationToUser(BuildContext context, User user, String visited) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProfileView(user, visited)));
  }

  void _navigationToNotification(
      BuildContext context, User user, Notifictn notif) async {
    if ((notif.project != null) && (notif.user != null)) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NotificationsScreen(user, notif)));
    } else {
      await userService
          .deleteNotif(user.uname, notif.message)
          .then((value) async {
        if (value == 0) {
          int i = 0;
          for (i; i < user.notifications.length; i++) {
            if (user.notifications[i].message == notif.message) {
              user.notifications.remove(notif);
            }
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Notification deleted')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Something went wrong')));
        }
      });
    }
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
