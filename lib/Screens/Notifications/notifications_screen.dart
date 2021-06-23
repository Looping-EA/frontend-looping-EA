import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/ProfileView/profileView_screen.dart';
import 'package:frontend_looping_ea/Screens/feed/feed_proyectos.dart';
import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';
import 'package:frontend_looping_ea/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend_looping_ea/Models/project.dart';
import 'package:frontend_looping_ea/Models/notification.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'package:frontend_looping_ea/Services/project_service.dart';
import 'package:frontend_looping_ea/Services/user_service.dart';

class NotificationsScreen extends StatefulWidget {
  final Notifictn notif;
  final User user;
  NotificationsScreen(this.user, this.notif);

  @override
  State<StatefulWidget> createState() {
    return NotificationsState(user, notif);
  }
}

class NotificationsState extends State<NotificationsScreen> {
  final User user;
  final Notifictn notif;
  Widget _appBarTitle = new Text('Notifications');
  UserService userService = new UserService();
  ProjectService projectService = new ProjectService();

  NotificationsState(this.user, this.notif);
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
                      SizedBox(
                          width: width * 0.25,
                          height: height * 0.1,
                          child: ElevatedButton(
                              onPressed: _onPressButton,
                              style: ElevatedButton.styleFrom(
                                primary: Styles.colorBackground,
                              ),
                              child: Text(
                                'Accept',
                                style: Styles.button_big,
                              ))),
                      SizedBox(
                          width: width * 0.25,
                          height: height * 0.1,
                          child: ElevatedButton(
                              onPressed: _onPressReject,
                              style: ElevatedButton.styleFrom(
                                primary: Styles.colorBackground,
                              ),
                              child: Text(
                                'Reject',
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
                          notif.message,
                          style: Styles.projectText,
                        ))),
                SizedBox(height: height * 0.1),
                SizedBox(
                    width: width * 0.18,
                    height: height * 0.05,
                    child: ElevatedButton(
                        onPressed: visitProfile,
                        style: ElevatedButton.styleFrom(
                          primary: Styles.colorBackground,
                        ),
                        child: Text('View Profile', style: Styles.button_big)))
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

  void visitProfile() async {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new ProfileView(user, notif.user!)));
  }

  PreferredSizeWidget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
    );
  }

  void _onPressButton() async {
    await projectService
        .acceptRequest(notif.project, notif.user, user.uname)
        .then((value) async {
      print(value);
      if (value == 0) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('User accepted succesfully')));
      }
      if (value == 2) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You already handled this request')));
      }
    });
    await userService.getUser(user.uname).then((value) async {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new FeedProyectos(user: value)));
    });
  }

  void _onPressReject() async {
    await projectService
        .rejectRequest(notif.project, notif.user, user.uname)
        .then((value) async {
      print(value);
      if (value == 0) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Rejection sent correctly')));
      }
      if (value == 2) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You already handled this request')));
      }
    });
    await userService.getUser(user.uname).then((value) async {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new FeedProyectos(user: value)));
    });
  }
}
