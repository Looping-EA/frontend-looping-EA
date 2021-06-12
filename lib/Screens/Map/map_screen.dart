import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'map_state.dart';

class MapScreen extends StatefulWidget {
  final User user;
  MapScreen({key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MapState(this.user);
  }
}