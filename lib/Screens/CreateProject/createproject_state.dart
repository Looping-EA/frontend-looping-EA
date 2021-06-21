import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/feed/feed_proyectos.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';
import 'package:frontend_looping_ea/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend_looping_ea/Models/project.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Models/project.dart';
import 'package:frontend_looping_ea/Services/project_service.dart';
import '../../Shared/shared_preferences.dart';

class CreateProjectState extends State<CreateProjectScreen> {
  final User user;
  CreateProjectState(this.user);
  ProjectService projectService = new ProjectService();
  final _formKey = GlobalKey<FormBuilderState>();
  late final _project = Project("", [], "", [], [], "", [], user, []);

  @override
  Widget build(BuildContext context) {
    print(user.uname);
    return Scaffold(
        //An App Bar is created with the name of the current page
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text('Profile'),
        ),

        //The drawer opens a side menu
        drawer: SideMenu(user: this.user),
        backgroundColor: Styles.colorBackground,
        body: Center(
            child: Container(
                width: 700,
                height: 700,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black38,
                      offset: new Offset(10.0, 10.0),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create a new project ',
                          style: Styles.title,
                        )
                      ],
                    ),
                    FormBuilder(
                        key: _formKey,
                        child: SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                FormBuilderTextField(
                                  name: 'name',
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.minLength(context, 1),
                                  ]),
                                  decoration: InputDecoration(
                                      hintText: 'Enter the name of the project',
                                      labelText: "Name",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)))),
                                ),
                                SizedBox(height: 20),
                                FormBuilderTextField(
                                  maxLines: 7,
                                  name: 'description',
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context)
                                  ]),
                                  decoration: InputDecoration(
                                      hintText: 'Enter the description',
                                      labelText: "Description",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)))),
                                ),
                                SizedBox(height: 20)
                              ],
                            ))),
                    SizedBox(height: 10),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black26,
                              offset: new Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                        child: SizedBox(
                            height: 60,
                            width: 120,
                            child: ElevatedButton(
                                onPressed: _onPressButton,
                                style: ElevatedButton.styleFrom(
                                  primary: Styles.colorBackground,
                                ),
                                child: Text(
                                  'Create',
                                  style: Styles.button_big,
                                ))))
                  ],
                ))));
  }

  void _onPressButton() {
    final validator = _formKey.currentState!.validate();

    if (validator) {
      // SAVE THE STATE OF THE FORM
      _formKey.currentState!.save();

      // GRAB THE FIELDS
      _project.name = _formKey.currentState!.fields['name']!.value;
      _project.description =
          _formKey.currentState!.fields['description']!.value;

      // http?
      try {
        projectService.createProject(_project, user.uname).then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FeedProyectos(user: this.user)));
        });
      } catch (err) {
        print(err);
      }
    } else {}
  }
}
