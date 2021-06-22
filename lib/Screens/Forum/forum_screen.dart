/*import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Services/user_service.dart';
import 'package:frontend_looping_ea/Services/project_service.dart';
import 'package:frontend_looping_ea/Models/entry.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';
import 'package:frontend_looping_ea/Screens/Notifications/notifications_screen.dart';
import 'package:frontend_looping_ea/Screens/Entry/entry_screen.dart';
import 'package:frontend_looping_ea/Models/notification.dart';

class ForumScreen extends StatefulWidget {
  final User user;
  ForumScreen({key, required this.user}) : super(key: key);

  _ForumState createState() => _ForumState(this.user);
}

//TODO: implement ForumState, that is able to show a list of the different
//ENTRIES of an SPECIFIC PROJECT!!! This page should be also able to search
//through the etries with a topbar searcher.

class _ForumState extends State<ForumScreen> {
  int notifications = 0;
  final User user;
  late Future<List<Entry>> entries;
  List<Entry> entryName= [];
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<Entry> filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Forum about your projects');
  UserService userService = new UserService();

  ProjectService projectService = new ProjectService();

  _ForumState(this.user) {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = entryName;
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
    projectService.getProjectsAndOwners().then((result) {
      setState(() {
        entryName = result;
        filteredNames = entryName;
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
        title: 'Forums',
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
                    heroTag: "search",
                    backgroundColor: Colors.blueGrey,
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
                hintText: 'Search forums...'));
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Forums about your projects');
        filteredNames = entryName;
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
      List<Entry> tempList = [];
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
      itemCount: entryName == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index].name),
          subtitle: Text(filteredNames[index].name),
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
                title: Text(user.notifications[index].message),
                onTap: () {
                  _navigationToNotification(
                      context, user, user.notifications[index]);
                },
              );
            }));
  }

  List<Entry> getProjectObjects(data) {
    List<Entry> entries = [];
    for (var project in data) {
      entries.add(project);
    }
    return entries;
  }

  // Al clicar en un proyecto entrar en el
  void _navigationToProject(BuildContext context,Entry entry, User user) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EntryScreen(entry: entry, user: user)));
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
  }
}*/