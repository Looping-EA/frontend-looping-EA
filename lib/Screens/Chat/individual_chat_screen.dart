import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/chat.dart';
import 'package:frontend_looping_ea/Screens/Chat/Cards/ownMessage_card.dart';
import 'package:frontend_looping_ea/Screens/Chat/Cards/reply_card.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualChat extends StatefulWidget {
  IndividualChat({key, required this.chat}) : super(key: key);
  final Chat chat;
  //final int id;
  @override
  State<StatefulWidget> createState() => _IndividualChatState();
}

class _IndividualChatState extends State<IndividualChat> {
  late IO.Socket socket;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    String url = 'http://localhost:3000';
    socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.on("connect", (data) {
      print("You are connected.");
      socket.on("message", (msg) {
        print(msg);
      });
    });
    socket.emit("/test", "Hola Xape");
    //Pasar id del usuario, hay que cambirarlo por la id correcta
    socket.emit("signin", 1);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Scaffold(
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
              Container(
                  height: size.height * 0.85,
                  child: ListView(
                    children: [
                      OwnMessageCard(),
                      ReplyCard(),
                    ],
                  )),
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
                                controller: _controller,
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
                              onPressed: () {
                                sendMessage(_controller.text, 1, 2);
                                _controller.clear();
                              },
                              child: Text("Send"))),
                    ],
                  ))
            ])),
      )
    ]);
  }
}
