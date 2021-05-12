import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'createproject_state.dart';

class CreateProjectScreen extends StatefulWidget {
  final User user;
  CreateProjectScreen({key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CreateProjectState(this.user);
  }
}
