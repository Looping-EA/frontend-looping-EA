import 'package:frontend_looping_ea/Models/chat.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/Chat/Cards/user_card.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  final User user;
  UsersScreen({Key? key, required this.user}) : super(key: key);
  @override
  _UsersScreenState createState() => _UsersScreenState(this.user);
}

class _UsersScreenState extends State<UsersScreen> {
  final User user;
  late Future<List<User>> users;
  String _searchText = "";
  _UsersScreenState(this.user);
  @override
  Widget build(BuildContext context) {
    List<User> contacts = [
      User("Xape", "xape23", "Marc Xapelli", "marcxapelli@hotmail.com"),
      User("Luis", "luis54", "Luis Domingo", "luis.domingo@gmail.com"),
      User("MaFe", "mafe45", "Marc Ferre", "marcferre@upc.edu")
    ];
    return Scaffold(
      body:
          //Column(children: [
          ListView.builder(
        itemBuilder: (context, index) => UserCard(contact: contacts[index]),
        itemCount: contacts.length,
      ),
    );
  }
}
