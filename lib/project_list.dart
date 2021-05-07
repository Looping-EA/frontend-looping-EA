import 'package:flutter/material.dart';
import "Models/project.dart";
import 'styles.dart';

class ProjectList extends StatelessWidget {
  final List<Project> projects;

  ProjectList(this.projects);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("projects", style: Styles.subtitle)),
      body: ListView.builder(
        itemCount: this.projects.length,
        itemBuilder: _listViewItemBuilder,
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var project = this.projects[index];
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      //leading: _itemThumbnail(this.projects[index]),
      title: _itemTitle(project),
      onTap: () {
        //_navigationToProjectDetail(context, project);
      },
    );
  }

  // Al clicar en un proyecto entrar en el, como no hay pagina de proyecto todavia no esta operativa
  //void _navigationToProjectDetail(BuildContext context, Project project) {
  //Navigator.push(context,
  //MaterialPageRoute(builder: (context) => ProjectDetail(project)));
  //}

  // Por si queremos poner imagen al proyecto
  //Widget _itemThumbnail(Project project) {
  //return Container(
  //constraints: BoxConstraints.tightFor(width: 100.0),
  //child: Image.network(project.url, fit: BoxFit.fitWidth),
  //);
  //}

  Widget _itemTitle(Project project) {
    return Text('${project.name}', style: Styles.subtitle);
  }
}
