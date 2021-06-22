import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/project.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';
import 'package:frontend_looping_ea/Services/project_service.dart';
import 'package:frontend_looping_ea/Services/user_service.dart';

import '../../styles.dart';

class StadisticsScreen extends StatefulWidget {
  final User user;
  StadisticsScreen({Key? key, required this.user}) : super(key: key);

  @override
  _StadisticsScreenState createState() => _StadisticsScreenState(this.user);
}

class _StadisticsScreenState extends State<StadisticsScreen> {
  final User user;
  _StadisticsScreenState(this.user);
  late Future<List<Project>> projects;
  late Future<List<User>> users;
  String numberProjects = "";
  String numberUsers = "";
  String numberProjectOwners = "";
  Widget _appBarTitle = new Text('Statistics');

  ProjectService projectService = new ProjectService();
  UserService userService = new UserService();

  @override
  void initState() {
    super.initState();
    // try {
    projectService.getProjectsAndOwners().then((result) {
      setState(() {
        int numberPrjcts = 0;
        for (int i = 0; i < result.length; i++) {
          numberPrjcts++;
        }
        numberProjects = numberPrjcts.toString();
      });
    });
    userService.getUsers().then((result) {
      setState(() {
        int numberUsuarios = result;
        numberUsers = numberUsuarios.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _buildBar(context),
      drawer: SideMenu(user: this.user),
      body: Container(
          margin: EdgeInsets.fromLTRB(width * 0.1, 0, width * 0.1, 0),
          width: width,
          height: MediaQuery.of(context).size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.05),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Number of available projects: " + numberProjects,
                          style: Styles.projectText),
                      Text("Number of registered users: " + numberUsers,
                          style: Styles.projectText)
                    ])
              ])),
    );
  }

  PreferredSizeWidget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
    );
  }
}
