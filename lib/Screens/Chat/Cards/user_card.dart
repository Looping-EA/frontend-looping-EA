import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';

import '../../../styles.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.contact}) : super(key: key);
  final User contact;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: ListTile(
            leading: CircleAvatar(radius: 20),
            title: Text(contact.uname, style: Styles.projectText),
            subtitle: Text(contact.fullname, style: TextStyle(fontSize: 13))));
  }
}
