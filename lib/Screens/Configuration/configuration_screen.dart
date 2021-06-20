import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'configuration_state.dart';

class ConfigurationScreen extends StatefulWidget {
  final User user;
  ConfigurationScreen({key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ConfigurationScreenState(this.user);
  }
}
