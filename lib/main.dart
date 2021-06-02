//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Screens/Homepage/home_screen.dart';
import 'package:frontend_looping_ea/Screens/Profile/profile_screen.dart';
import 'package:frontend_looping_ea/Screens/Project/project_screen.dart';
import 'package:frontend_looping_ea/Screens/feed/feed_proyectos.dart';
import 'package:frontend_looping_ea/Screens/ConfigCuenta/ConfigCuenta.dart';
import 'Screens/Splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Config(),
    );
  }
}

class Check {
  String titulo;
  bool valor;
  Check({required this.titulo, this.valor = false});
}

class Config extends StatefulWidget {
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  final Checked =
      Check(titulo: 'Clicar aquí, si desea todas las configuraciones');
  final checkList = [
    Check(titulo: 'Habilitar notificaciones'),
    Check(titulo: 'Habilitar privacidad'),
    Check(titulo: 'Habilitar autenticacion en dos pasos'),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Configuracion de cuenta'),
        centerTitle: true,
        leading: Icon(Icons.account_circle_rounded),
        leadingWidth: 100,
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => onClicked(Checked),
            leading: Checkbox(
              value: Checked.valor,
              onChanged: (valor) => onClicked(Checked),
            ),
            title: Text(Checked.titulo,
                style: TextStyle(fontSize: 15, color: Colors.black)),
          ),
          Divider(),
          ...checkList
              .map(
                (objeto) => ListTile(
                  onTap: () => ObjetoClicked(objeto),
                  leading: Checkbox(
                    value: objeto.valor,
                    onChanged: (valor) => ObjetoClicked(objeto),
                  ),
                  title: Text(objeto.titulo,
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                ),
              )
              .toList()
        ],
      ),
    ));
  }

  onClicked(Check comprobar) {
    final nuevoValor = !comprobar.valor;
    setState(() {
      comprobar.valor = nuevoValor;
      checkList.forEach((element) {
        element.valor = nuevoValor;
      });
    });
  }

  ObjetoClicked(Check comprobar) {
    setState(() {
      comprobar.valor = !comprobar.valor;
    });
  }
}
