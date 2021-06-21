import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Models/configuration.dart';
import 'package:frontend_looping_ea/Screens/Configuration/configuration_screen.dart';
import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ConfigurationScreenState extends State<ConfigurationScreen> {
  final User user;
  ConfigurationScreenState(this.user);

  bool? notificationChecked = false;
  bool? securityChecked = false;
  bool? privacityChecked = false;

  String mynotificaciones = "no";
  String myseguridad = "no";
  String myprivacidad = "no";

  @override
  void initState() {
    super.initState();
    if (mynotificaciones == "si") {
      //notificationChecked = true;
      bool val = true;
      setState(() {
        notificationChecked = val;
      });
    } else if (myseguridad == "si") {
      securityChecked = true;
    } else if (myprivacidad == "si") {
      privacityChecked = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Set your account preferences"),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              value: notificationChecked,
              onChanged: (val) {
                setState(() {
                  notificationChecked = val;
                  _buscar();
                });
              },
              activeColor: Colors.green,
              title: Text("Notifications"),
              subtitle: Text("Click if you want recieve notification"),
            ),
            CheckboxListTile(
              value: securityChecked,
              onChanged: (val) {
                setState(() {
                  securityChecked = val;
                  _buscar();
                });
              },
              activeColor: Colors.green,
              title: Text("Security"),
              subtitle: Text("Click if you want to have security in two steps"),
            ),
            CheckboxListTile(
              value: privacityChecked,
              onChanged: (val) {
                setState(() {
                  privacityChecked = val;
                  _buscar();
                });
              },
              activeColor: Colors.green,
              title: Text("Privacity"),
              subtitle: Text("Click if you want to set up a private account"),
            )
          ]),
    );
  }

  void _buscar() {
    print(mynotificaciones);
    if (notificationChecked == true) {
      mynotificaciones = "si";
      _add();
      print(mynotificaciones);
    } else if (securityChecked == true) {
      myseguridad = "si";
      _add();
    } else if (privacityChecked == true) {
      myprivacidad = "si";
      _add();
    } else if (notificationChecked == false) {
      mynotificaciones = "no";
      _add();
    } else if (securityChecked == false) {
      myseguridad = "no";
      _add();
    } else if (privacityChecked == false) {
      myprivacidad = "no";
      _add();
    }
  }

  Future<Configuration> _add() async {
    Configuration configuration = new Configuration("", "", "", "");

    String? token;
    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
    }

    // create JSON object
    final body = {
      "uname": user.uname,
      "notificaciones": mynotificaciones,
      "seguridad": myseguridad,
      "privacidad": myprivacidad,
    };
    final bodyParsed = json.encode(body);

    // finally the PUT HTTP operation
    return await http
        .post(Uri.parse("http://localhost:8080/api/configuracion/add"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
            body: bodyParsed)
        .then((http.Response response) {
      if (response.statusCode == 201) {
        return Configuration.fromJson(json.decode(response.body));
      } else {
        return new Configuration("", "", "", "");
      }
    });
  }

  Future<List<Configuration>> getConfiguracions() async {
    List<Configuration> configurations = [];
    String? token;
    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
    }

    final response = await http
        .get(Uri.parse('http://localhost:8080/api/configuracion/'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 201) {
      var locationsJson = json.decode(response.body);
      try {
        for (var locationJson in locationsJson) {
          configurations.add(Configuration(
              locationJson["uname"],
              locationJson["notificaciones"],
              locationJson["seguridad"],
              locationJson["privacidad"]));
        }
      } catch (e) {
        print(e);
      }
    }
    return configurations;
  }

  Future<Configuration> _updateConfiguracion() async {
    Configuration configuration = new Configuration("", "", "", "");

    String? token;
    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
    } catch (err) {
      print(err);
    }

    // create JSON object
    final body = {
      "uname": user.uname,
      "notificaciones": mynotificaciones,
      "seguridad": myseguridad,
      "privacidad": myprivacidad
    };
    final bodyParsed = json.encode(body);

    // finally the PUT HTTP operation
    return await http
        .put(Uri.parse("http://localhost:8080/api/configuracion/update"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
            body: bodyParsed)
        .then((http.Response response) {
      if (response.statusCode == 201) {
        return Configuration.fromJson(json.decode(response.body));
      } else {
        return new Configuration("", "", "", "");
      }
    });
  }
}
