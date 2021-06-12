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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
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
      body: Container(
          height: size.height,
          width: size.width,
          child: Stack(children: [
            ListView(),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            size.width * 0.05, 0, size.width * 0.05, 0),
                        width: size.width * 0.75,
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.05)),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              minLines: 1,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type a message",
                                  contentPadding:
                                      EdgeInsets.all(size.width * 0.01)),
                            ))),
                    Container(
                        height: size.height * 0.05,
                        width: size.width * 0.1,
                        child: ElevatedButton(
                            onPressed: onPressed, child: Text("Send"))),
                  ],
                ))
          ])),
    );
  }

  void onPressed() {}
}
