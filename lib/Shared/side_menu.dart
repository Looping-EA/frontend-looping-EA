import 'dart:html';

import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'package:frontend_looping_ea/Screens/Map/map_screen.dart';
import 'package:frontend_looping_ea/Screens/Profile/profile_screen.dart';
import 'package:frontend_looping_ea/Screens/Register/register_screen.dart';
import 'package:frontend_looping_ea/Screens/feed/feed_proyectos.dart';
import 'package:frontend_looping_ea/Services/user_service.dart';
import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:frontend_looping_ea/Models/user.dart';

// ignore: must_be_immutable
class SideMenu extends StatefulWidget {
  final User user;
  SideMenu({Key? key, required this.user}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState(this.user);
}

class _SideMenuState extends State<SideMenu> {
  final User user;

  _SideMenuState(this.user);

  @override
  Widget build(BuildContext context) {
    print(this.user.uname);
    return new Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: new Text(this.user.fullname,
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
          accountEmail: new Text(this.user.email,
              style: TextStyle(fontSize: 15.0, color: Colors.white)),
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          currentAccountPicture:
              const CircleAvatar(child: FlutterLogo(size: 42.00)),
        ),
        ListTile(
          title: Text("HOME",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.home),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FeedProyectos(user: this.user)));
          },
        ),
        ListTile(
          title: Text("PROFILE",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.account_box),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(user: this.user)));
          },
        ),
        ListTile(
          title: Text("CREATE PROJECT",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.chat),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CreateProjectScreen(user: this.user)));
          },
        ),
        ListTile(
          title: Text("FORUMS",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.forum),
        ),
        ListTile(
          title: Text("MAP",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.chat),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MapScreen(user: this.user)));
          },
        ),
        ListTile(
          title: Text("DELETE ACCOUNT",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.delete_forever_sharp),
          onTap: () => _createAlertDialog(context, this.user.uname),
        ),
      ],
    ));
  }

  Future<void> _createAlertDialog(BuildContext context, String uname) {
    TextEditingController customController = TextEditingController();
    String confirmation = "I understand";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                "Are you sure you want to leave us?  Write!:' I understand '"),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Send'),
                onPressed: () {
                  deleteUser(uname).then((value) {
                    if (value == "deleted") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    } else {
                      Navigator.of(context)
                          .pop(customController.text.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(user: this.user)));
                    }
                  });
                },
              )
            ],
          );
        });
  }
}
