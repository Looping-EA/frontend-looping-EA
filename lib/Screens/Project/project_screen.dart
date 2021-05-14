import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/project.dart';
import 'package:frontend_looping_ea/Models/user.dart';

import 'project_state.dart';

class ProjectScreen extends StatefulWidget {
  final Project project;
  final User user;

  ProjectScreen(this.project, this.user);

  @override
  State<StatefulWidget> createState() {
    return ProjectState(project, user);
  }
}
