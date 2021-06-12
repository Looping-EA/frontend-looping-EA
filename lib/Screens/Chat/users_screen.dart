import 'package:frontend_looping_ea/Models/chat.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/Chat/user_card.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  final url = 'http://localhost:3000';
  final IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  get data => null;
  @override
  Widget build(BuildContext context) {
    List<User> contacts = [
      User("Xape", "xape23", "Marc Xapelli", "marcxapelli@hotmail.com",
          "45GHF%678IK"),
      User("Luis", "luis54", "Luis Domingo", "luis.domingo@gmail.com",
          "61HJ9LM45"),
      User("MaFe", "mafe45", "Marc Ferre", "marcferre@upc.edu", "IYT42D678G")
    ];
    return Scaffold(
      body:
          //Column(children: [
          ListView.builder(
        itemBuilder: (context, index) => UserCard(contact: contacts[index]),
        itemCount: contacts.length,
      ),
      //Container(
      //child: Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      //children: <Widget>[
      //ElevatedButton(
      // onPressed: _onPressButton,
      //style: ElevatedButton.styleFrom(),
      //child: Text(
      // 'Get Socket',
      //)),
      //SizedBox(height: 50),
      //ElevatedButton(
      // onPressed: _sendMessage,
      // style: ElevatedButton.styleFrom(),
      // child: Text(
      //   'Send Message',
      // )),]))])
    );
  }

  void _onPressButton() async {
    socket.connect();
    socket.on("connect", (_) => {print("You are connected.")});
    socket.on(
        "disconnect", (_) => print('You have disconnected from the server.'));
    socket.on("new message", (data) => _addChatMessage(data));
    // Dart client
  }

  void _sendMessage() async {
    socket.emit("new message", "Hola");
    print("Message sent");
  }

  void _addChatMessage(data) {
    print("Message received");
    //print(data.message);
    //print(data.id);
  }
}
