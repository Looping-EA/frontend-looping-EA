import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'package:frontend_looping_ea/Screens/Faqs/faqs_screen.dart';
import 'package:frontend_looping_ea/Screens/Login/login_page.dart';
import 'package:frontend_looping_ea/Screens/Map/map_screen.dart';
import 'package:frontend_looping_ea/Screens/Profile/profile_screen.dart';
import 'package:frontend_looping_ea/Screens/Register/register_screen.dart';
import 'package:frontend_looping_ea/Screens/feed/feed_proyectos.dart';
import 'package:frontend_looping_ea/Screens/Configuration/configuration_screen.dart';
import 'package:frontend_looping_ea/Services/user_service.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/Stadistics/stadistics_screen.dart';
import 'package:frontend_looping_ea/Screens/Contacto/contactoscreen.dart';
import 'package:frontend_looping_ea/Screens/Forum/forum_screen.dart';

// ignore: must_be_immutable
class SideMenu extends StatefulWidget {
  final User user;
  SideMenu({Key? key, required this.user}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState(this.user);
}

class _SideMenuState extends State<SideMenu> {
  final User user;
  UserService userService = new UserService();

  _SideMenuState(this.user);

  @override
  Widget build(BuildContext context) {
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
            currentAccountPicture: buildPhoto(user)),
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
          onTap: () async {
            await userService.getUser(user.uname).then((value) async {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ProfileScreen(user: value)));
            });
          },
        ),
        ListTile(
          title: Text("CREATE PROJECT",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.add),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CreateProjectScreen(user: this.user)));
          },
        ),
        ListTile(
          title: Text("MAP",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.map),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapScreen(user: this.user)));
          },
        ),
        ListTile(
            title: Text("FORUMS",
                style: TextStyle(fontSize: 18.0, color: Colors.black)),
            leading: const Icon(Icons.forum),
            onTap: () async {
              await userService.getUserProject(user.uname).then((projects) async {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ForumScreen(user: this.user, projects: projects)));
              });
            }),
        ListTile(
          title: Text("CONTACT",               
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.contact_page),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContactoScreen(user: this.user)));
          },
        ),
        ListTile(
          title: Text("ACCOUNT CONFIGURATION",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.settings),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ConfigurationScreen(user: this.user)));
          },
        ),
        ListTile(
            title: Text("LOG OUT",
                style: TextStyle(fontSize: 18.0, color: Colors.black)),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()));
            }),
        ListTile(
          title: Text("DELETE ACCOUNT",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.delete_forever_sharp),
          onTap: () => _createAlertDialog(context, this.user.uname),
        ),
        ListTile(
            title: Text("STATISTICS",
                style: TextStyle(fontSize: 18.0, color: Colors.black)),
            leading: const Icon(Icons.accessibility_outlined),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StadisticsScreen(user: this.user)));
            }),
        ListTile(
          title: Text("FAQS",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.help),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FaqsScreen()));
          },
        )
      ],
    ));
  }

  CircleAvatar buildPhoto(User user) {
    try {
      if ((user.photo == null) || (user.photo == "")) {
        return CircleAvatar(child: FlutterLogo(size: 42.00), radius: 42);
      } else {
        try {
          return CircleAvatar(backgroundImage: NetworkImage(user.photo!));
        } catch (e) {
          print(e);
          return CircleAvatar(child: FlutterLogo(size: 42.00), radius: 42);
        }
      }
    } catch (e) {
      print(e);
      return CircleAvatar(child: FlutterLogo(size: 42.00), radius: 42);
    }
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
                  userService.deleteUser(uname).then((value) {
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
