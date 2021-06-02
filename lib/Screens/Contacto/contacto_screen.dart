import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'contacto_state.dart';

class ContactoScreen extends StatefulWidget {
  final User user;
  ContactoScreen({key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ContactoState(this.user);
  }
}
