import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'entry_state.dart';
import 'package:frontend_looping_ea/Models/entry.dart';

class EntryScreen extends StatefulWidget {
  final User user;
  EntryScreen({key, required this.user, required this.entry}) : super(key: key);
  final Entry entry;

  @override
  State<StatefulWidget> createState() {
    return EntryState(this.user, this.entry);
  }
}
