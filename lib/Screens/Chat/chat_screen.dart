import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (
        SizedBox(
          height: 60,
          width: 120,
          child: ElevatedButton(
              onPressed: _onPressButton,
              style: ElevatedButton.styleFrom(
              ),
              child: Text(
                'REGISTER',
              )))
      ));
  }
void _onPressButton() async {

  print('se intenta');

  IO.Socket socket = IO.io('http://localhost:3000');


  socket.onConnect((_) {
    print('connect');
    socket.emit('msg', 'test');
  });
  socket.on('event', (data) => print(data));
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));
}
}

