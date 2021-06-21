import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'entry_state.dart';

class EntryScreen extends StatefulWidget {
  final User user;
  EntryScreen({key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EntryState(this.user);
  }
}
