import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/styles.dart';
import 'profile_image.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //An App Bar is created with the name of the current page
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Profile'),
      ),

      //The drawer opens a side menu
      drawer: SideMenu(),

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
                        child: Text('image')
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.fromLTRB(40.0, 0.0, 4.0, 0.0),
                        child: Text('Albert Sáez', style: TextStyle(fontSize: 30.0, color: Colors.white))
                      ),
                    ],
                  )
                ),
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
                child: Text('About me', style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold))
                ),
              Container(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Text('I love the Apple ecosystem', style: TextStyle(fontSize: 15.0, color: Colors.black))
                ),
            ],)
          ),

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
                child: Text('Skills', style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold))
                ),
              Container(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Text('Hockey', style: TextStyle(fontSize: 15.0, color: Colors.black))
                ),
            ],)
          ),

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
                child: Text('Projects', style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold))
                ),
              Container(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Text('Looping', style: TextStyle(fontSize: 15.0, color: Colors.black))
                ),
              ],          
            ),
          ),
        ],
      ),
    );
  }
}

//The SideMenu functions contains a basic information of the user and the different routes of the app
class SideMenu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Drawer(child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: new Text("Albert Sáez", style: TextStyle(fontSize: 20.0, color: Colors.white)), 
          accountEmail: new Text("Bill Gates come de sus migas", style: TextStyle(fontSize: 15.0, color: Colors.white)),
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          currentAccountPicture: const CircleAvatar(
            child: FlutterLogo(size: 42.00)
          ),
        ),
        ListTile(
          title: Text("HOME", style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.home),
          //CUANDO SEPAMOS LAS RUTAS SE APLICA A CADA UNA
          /*  onTap: (){
            Navigator.pop(),
          },*/
        ),
        ListTile(
          title: Text("PROFILE", style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.account_box),
        ),
        ListTile(
          title: Text("CHATS", style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.chat),
        ),
        ListTile(
          title: Text("FORUMS", style: TextStyle(fontSize: 18.0, color: Colors.black)),
          leading: const Icon(Icons.forum),
        ),
      ],
    ));
  }
}





