import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';
import 'package:frontend_looping_ea/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend_looping_ea/Models/project.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'project_screen.dart';
import 'package:frontend_looping_ea/Services/project_service.dart';

class ProjectState extends State<ProjectScreen> {
  final Project project;
  final User user;
  Widget _appBarTitle = new Text('Project');

  ProjectState(this.project, this.user);
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
                      Text(
                        project.name,
                        style: Styles.projectTextTitle,
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
                Container(
                    height: height * 0.3,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                        color: Styles.colorRelleno,
                        borderRadius: BorderRadius.circular(width * 0.05)),
                    child: Container(
                        margin: EdgeInsets.fromLTRB(width * 0.025,
                            width * 0.025, width * 0.025, width * 0.025),
                        child: Text(
                          project.description,
                          style: Styles.projectText,
                        ))),
                SizedBox(height: height * 0.1),
                Container(
                    height: height * 0.2,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                        color: Styles.colorRelleno,
                        borderRadius: BorderRadius.circular(width * 0.05)),
                    child: Container(
                        margin: EdgeInsets.fromLTRB(width * 0.025,
                            width * 0.025, width * 0.025, width * 0.025),
                        child: Text(
                          "Members: " + project.owner.uname,
                          style: Styles.projectText,
                        ))),
              ],
            )));
  }

  /*String ownersNameStringBuilder(Project x) {
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

  PreferredSizeWidget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
    );
  }

  void _onPressButton() async {
    await applyToProject(project, user, project.owner).then((value) async {
      print(value);
      if (value == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Application sent correctly')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error sending the application')));
      }
    });
  }
}
