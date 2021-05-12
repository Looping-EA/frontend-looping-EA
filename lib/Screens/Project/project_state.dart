import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';
import 'package:frontend_looping_ea/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend_looping_ea/Models/project.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'project_screen.dart';

class ProjectState extends State<ProjectScreen> {
  final Project project;
  final User user;
  Widget _appBarTitle = new Text('Project');

  ProjectState(this.project, this.user);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: _buildBar(context),
        drawer: SideMenu(user: this.user),
        body: Center(
            child: Container(
                width: width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.1),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Project name: " + project.name,
                            style: Styles.subtitleblue,
                          ),
                          SizedBox(
                              width: width * 0.25,
                              height: height * 0.1,
                              child: ElevatedButton(
                                  onPressed: _onPressButton,
                                  style: ElevatedButton.styleFrom(
                                    primary: Styles.colorBackground,
                                  ),
                                  child: Text(
                                    'Apply',
                                    style: Styles.button_big,
                                  )))
                        ]),
                    SizedBox(height: height * 0.1),
                    Text(
                      "Description: " + project.description,
                      style: Styles.subtitleblue,
                    ),
                    SizedBox(height: height * 0.1),
                    Text(
                      ownersNameStringBuilder(project),
                      style: Styles.subtitleblue,
                    ),
                  ],
                ))));
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

  PreferredSizeWidget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
    );
  }

  void _onPressButton() {}
}
