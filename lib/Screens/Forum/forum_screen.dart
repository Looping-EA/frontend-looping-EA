import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Services/user_service.dart';
import 'package:frontend_looping_ea/Services/project_service.dart';
import 'package:frontend_looping_ea/Models/entry.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';
import 'package:frontend_looping_ea/Screens/Entry/entry_screen.dart';
import 'package:frontend_looping_ea/Models/project.dart';

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
  late Future<List<Project>> projects;
  List <Project> projectName= [];
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<Project> filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search);
  UserService userService = new UserService();

  ProjectService projectService = new ProjectService();

  _ForumState(this.user) {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = projectName;
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
    userService.getUserProject(user.uname).then((result) {
      setState(() {
        projectName = result;
        filteredNames = projectName;
        notifications = user.notifications.length;
      });
    });
    // } catch (e) {
    //   print(e);
  }
//}

  @override
  Widget build(BuildContext context) {
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
    return AppBar(centerTitle: true, title: new Text('$user.uname Projects'));
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
        filteredNames = projectName;
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
      itemCount:projectName== null ? 0 : filteredNames.length,
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

  List<Entry> getProjectObjects(data) {
    List<Entry> entries = [];
    for (var project in data) {
      entries.add(project);
    }
    return entries;
  }

  // Al clicar en un proyecto entrar en el
  void _navigationToProject(BuildContext context,Project entry, User user) {
    /*Navigator.push(context,
        MaterialPageRoute(builder: (context) => EntryScreen(entry: entry, user: user)));
  */}

}
