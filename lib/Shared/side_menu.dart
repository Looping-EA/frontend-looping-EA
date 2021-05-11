import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Screens/Profile/profile_screen.dart';

class SideMenu extends StatelessWidget {
  Future<void> createAlertDialog(BuildContext context) {
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
                Navigator.of(context).pop(customController.text.toString());
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            )
          ],
        );
      });
  }
  @override
  Widget build(BuildContext context) {
    
    return new Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: new Text("Albert Sáez",
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
          accountEmail: new Text("Bill Gates come de sus migas",
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
          //CUANDO SEPAMOS LAS RUTAS SE APLICA A CADA UNA
          /*  onTap: (){
            Navigator.pop(),
          },*/
        ),
        ListTile(
          title: Text("PROFILE",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.account_box),
          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));},
        ),
        ListTile(
          title: Text("CHATS",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.chat),
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