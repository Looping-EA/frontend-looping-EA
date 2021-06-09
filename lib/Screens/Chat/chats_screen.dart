import 'package:frontend_looping_ea/Models/chat.dart';
import 'package:frontend_looping_ea/Screens/Chat/chat_card.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<Chat> chats = [
    Chat(
      "Xape",
      false,
      "16:04",
      "Hola Xape!",
    ),
    Chat("Albert", false, "13:19", "Has visto a Cacaman?"),
    Chat("Victor", false, "04:52", "Mandale"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemBuilder: (context, index) => ChatCard(chat: chats[index]),
      itemCount: chats.length,
    ));
  }
}
