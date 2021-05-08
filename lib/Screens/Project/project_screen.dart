import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/project.dart';

import 'project_state.dart';

class ProjectScreen extends StatefulWidget {
  final Project project;

  ProjectScreen(this.project);

  @override
  State<StatefulWidget> createState() {
    return ProjectState(project);
  }
}
