import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/Chat/chats_screen.dart';
import 'package:frontend_looping_ea/Screens/Chat/users_screen.dart';

class AllChatsScreen extends StatefulWidget {
  final User user;
  AllChatsScreen({Key? key, required this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AllChatsState(user);
}

class _AllChatsState extends State<AllChatsScreen>
    with SingleTickerProviderStateMixin {
  final User user;
  late TabController _controller;
  _AllChatsState(this.user);
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text("Chats"),
            actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
            bottom: TabBar(
                controller: _controller,
                indicatorColor: Colors.black,
                tabs: [Tab(text: "OPEN CHATS"), Tab(text: "USERS")])),
        body: TabBarView(
          controller: _controller,
          children: [ChatsScreen(), UsersScreen(user: user)],
        ));
  }
}
