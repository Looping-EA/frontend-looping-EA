import "package:flutter/material.dart";
import 'package:frontend_looping_ea/Models/chat.dart';
import 'package:frontend_looping_ea/Screens/Chat/individual_chat_screen.dart';
import 'package:frontend_looping_ea/styles.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  ChatCard({key, required this.chat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IndividualChat(chat: chat)));
        },
        child: Column(children: [
          ListTile(
              leading: CircleAvatar(radius: 20),
              title: Text(chat.name, style: Styles.projectText),
              subtitle:
                  Text(chat.currentMessage, style: TextStyle(fontSize: 13)),
              trailing: Text(chat.time))
        ]));
  }
}
