import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/chat.dart';

class IndividualChat extends StatefulWidget {
  IndividualChat({key, required this.chat}) : super(key: key);
  final Chat chat;
  @override
  State<StatefulWidget> createState() => _IndividualChatState();
}

class _IndividualChatState extends State<IndividualChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 70,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.arrow_back, size: 24),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black12,
                )
              ])),
          title: Column(
            children: [Text(widget.chat.name)],
          )),
    );
  }
}
