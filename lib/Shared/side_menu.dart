import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/project.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'package:frontend_looping_ea/Screens/Profile/profile_screen.dart';
import 'package:frontend_looping_ea/Screens/Project/project_screen.dart';
import 'package:frontend_looping_ea/Screens/Project/project_state.dart';
import 'package:frontend_looping_ea/Screens/Register/register_screen.dart';
import 'package:frontend_looping_ea/Screens/feed/feed_proyectos.dart';
import 'package:frontend_looping_ea/Services/user_service.dart';
import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:frontend_looping_ea/Models/user.dart';

class SideMenu extends StatelessWidget {
  Future<void> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    String confirmation = "I understand";
    String? uname;
    getUsernameFromSharedPref().then((value) => uname = value);

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
                  String answer = "hola";
                  deleteUser(uname).then((value) => answer = value);
                  if (answer == "deleted") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  } else {
                    Navigator.of(context).pop(customController.text.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  }
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    
    late final User user;
    String? username;
    getUsernameFromSharedPref().then((value) => username = value);
    getUser(username).then((value) => user = value);

    return new Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: new Text("${user.fullname}",
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
          accountEmail: new Text("${user.email}",
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FeedProyectos()));
          },
        ),
        ListTile(
          title: Text("PROFILE",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.account_box),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
        ),
        ListTile(
          title: Text("CREATE PROJECT",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.chat),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateProjectScreen()));
          },
        ),
        ListTile(
          title: Text("FORUMS",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.forum),
        ),
        ListTile(
          title: Text("DELETE ACCOUNT",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.delete_forever_sharp),
          onTap: () => createAlertDialog(context),
        ),
      ],
    ));
  }
}
