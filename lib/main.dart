import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Screens/Homepage/home_screen.dart';
import 'package:frontend_looping_ea/Screens/Profile/profile_screen.dart';
import 'package:frontend_looping_ea/Screens/Project/project_screen.dart';
import 'package:frontend_looping_ea/Screens/feed/feed_proyectos.dart';
import 'Screens/Chat/allchats_screen.dart';
import 'Screens/Splash/splash_screen.dart';
import 'package:frontend_looping_ea/Screens/Chat/chats_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AllChatsScreen(),
    );
  }
}
