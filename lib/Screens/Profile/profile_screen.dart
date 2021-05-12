import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  final User user;
  ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState(this.user);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User user;
  _ProfileScreenState(this.user) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //An App Bar is created with the name of the current page
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Profile'),
      ),

      //The drawer opens a side menu
      drawer: SideMenu(user: this.user),

      //BackgroundColor of the page
      backgroundColor: Colors.white10,

      //The body contains all the profile information
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //In this container there is the picture, name and icon to the chat
          Container(
            height: 200.0,
            color: Colors.blueGrey,
            padding: const EdgeInsets.all(32.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //ImageBanner(),
                    Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(bottom: 8),
                        width: 50.0,
                        margin: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
                        //padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                        child: Text('image')),
                    Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.fromLTRB(40.0, 0.0, 4.0, 0.0),
                        child: Text(user.fullname,
                            style: TextStyle(
                                fontSize: 30.0, color: Colors.white))),
                  ],
                )),
                Icon(Icons.chat, color: Colors.white)
              ],
            ),
          ),

          //This container contains the information about me
          Container(
              margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              color: Colors.grey,
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      child: Text('About me',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: Text(user.email,
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black))),
                ],
              )),

          //This container constains the information Skills
          Container(
              margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              color: Colors.grey,
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      child: Text('Skills',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: Text(user.email,
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black))),
                ],
              )),

          //This container contains the information of the Projects
          Container(
            margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            color: Colors.grey,
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    child: Text('Projects',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))),
                Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Text(user.email,
                        style: TextStyle(fontSize: 15.0, color: Colors.black))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
