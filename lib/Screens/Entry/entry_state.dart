import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/Entry/entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/entry.dart';

class EntryState extends State<EntryScreen> {
  final User user;
  EntryState(this.user, this.entry);
  final Entry entry;

  @override
  void initState() {
    super.initState();
  }

  //TODO: implement Entry screen. Show listview of posts, with icons that allow to 
  //publish a new post(name of the user, date, msg). 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text(
            "caca"
            )
        );
  }
}
