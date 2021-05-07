import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/styles.dart';
import 'profile_image.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //ImageBanner(),
                Container(
                  margin: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                  padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                  child: Text('image')
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(40.0, 4.0, 4.0, 4.0),
                  child: Text('name', style: TextStyle(fontSize: 40.0, color: Colors.white))
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            color: Colors.grey,
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Text('About me', style: TextStyle(fontSize: 20.0, color: Colors.black)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            color: Colors.grey,
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Text('Skills', style: TextStyle(fontSize: 20.0, color: Colors.black)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            color: Colors.grey,
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Text('Projects', style: TextStyle(fontSize: 20.0, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
