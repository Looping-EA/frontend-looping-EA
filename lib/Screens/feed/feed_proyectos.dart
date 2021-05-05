import 'package:flutter/material.dart';
import '../../Models/project.dart';

void main() => runApp(FeedProyectos());

class FeedProyectos extends StatefulWidget {
  @protected
  @mustCallSuper
  /* void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => getProjects(context));
  }*/

  @override
  _FeedProyectosState createState() => _FeedProyectosState();
}

class _FeedProyectosState extends State<FeedProyectos> {
  List<Project> projects = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feed Proyectos',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Proyectos'),
        ),
        body: ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(projects[index].name),
                  subtitle: Text(
                    projects[index].owners.toString(),
                  ));
            }),
      ),
    );
  }
}
