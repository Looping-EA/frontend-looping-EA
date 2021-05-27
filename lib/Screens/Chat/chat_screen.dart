import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (SizedBox(
            height: 60,
            width: 120,
            child: ElevatedButton(
                onPressed: _onPressButton,
                style: ElevatedButton.styleFrom(),
                child: Text(
                  'Get Socket',
                )))));
  }

  void _onPressButton() async {
    print('se intenta');
    var url = 'http://localhost:3000';
    print(url);

    try {
      IO.Socket socket = IO.io(url, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      print("hola");
      socket.connect();
      socket.onConnect((_) => {print('connect')});
      socket.on('event', (data) => print(data));
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print("error");
      print(e);
    }
    ;

    // Dart client
  }
}
