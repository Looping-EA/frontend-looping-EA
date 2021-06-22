import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/entry.dart';
import 'package:frontend_looping_ea/Models/notification.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
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

class ProjectEntry extends StatefulWidget {
  final User user;
  ProjectEntry({Key? key, required this.user}) : super(key: key);

  @override
  _ProjectEntryState createState() => _ProjectEntryState(this.user);
}

class _ProjectEntryState extends State<ProjectEntry> {
  
  final User user;
  late Future<List<Entry>> entries;
  List<Entry> entryNames = [];
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<Entry> filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Project Entries');
  UserService userService = new UserService();

  ProjectService projectService = new ProjectService();

  _ProjectEntryState(this.user) {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = entryNames;
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
        //entryNames = result;
        filteredNames = entryNames;
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
        title: 'Project Entries',
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
                    //backgroundColor: Colors.blueGrey,
                    child: Icon(Icons.add),
                    onPressed: () {
                      _navigationToCreateProject(context);
                    }),
                FloatingActionButton(
                    heroTag: "search",
                    //backgroundColor: Colors.blueGrey,
                    child: Icon(Icons.search),
                    onPressed: () {
                      _searchPressed();
                    }),
              ],
            )));
  }

  PreferredSizeWidget _buildBar(BuildContext context) {
    return AppBar(centerTitle: true, title: _appBarTitle, backgroundColor: Colors.blueGrey);
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
        filteredNames = entryNames;
        _filter.clear();
      }
    });
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
      itemCount: entryNames == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index].name),
          subtitle: Text(filteredNames[index].description),
          onTap: () {
            _navigationToProject(context, filteredNames[index], user);
          },
        );
      },
    );
  }

  List<Entry> getEntryObjects(data) {
    List<Entry> entries = [];
    for (var entry in data) {
      entries.add(entry);
    }
    return entries;
  }

  // Al clicar en un proyecto entrar en el
  void _navigationToProject(BuildContext context, Entry entry, User user) {
    /*Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProjectEntry(user)));*/
  }

  void _navigationToCreateProject(BuildContext context) {
    /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateProjectScreen(user: this.user)));*/
  }
}