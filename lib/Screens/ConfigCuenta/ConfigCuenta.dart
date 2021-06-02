/*import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'package:frontend_looping_ea/Screens/Login/login_page.dart';
import 'package:frontend_looping_ea/Screens/Register/register_screen.dart';
import 'package:frontend_looping_ea/Screens/feed/feed_proyectos.dart';
//import 'package:flutter/cupertino.dart';

import '../../styles.dart';

class Config extends StatefulWidget {
  const Config({Key key}) : super(key: key);

  _RegisterFormState
}

class ConfScreen extends StatelessWidget {
  bool _check = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.account_circle_rounded),
        leadingWidth: 100,
        backgroundColor: Colors.blueGrey,
        title: Text('Configuracion de cuenta'),
        centerTitle: true,
      ),
      body: Row(
        children: <Widget>[
          Checkbox(
              value: _check,
              onChanged: (isChecked) {
                setState(() {
                  _check = isChecked;
                });
              }),
          Text("Habilitar o deshabilitar notificaciones"),
        ],
      ),
    );
  }
}*/
