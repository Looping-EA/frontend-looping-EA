import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/Register/register_screen.dart';

//import styles
import 'package:frontend_looping_ea/styles.dart';

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _user = User("", "", "", "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          'Become a ',
                          style: Styles.title,
                        ),
                        DecoratedBox(
                            decoration: BoxDecoration(color: Colors.black),
                            child: Text(
                              'Develooper.',
                              style: Styles.subText,
                            ))
                      ],
                    ),
                    FormBuilder(
                        child: SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                FormBuilderTextField(name: 'username'),
                                SizedBox(height: 10),
                                FormBuilderTextField(name: 'email'),
                                SizedBox(height: 10),
                                FormBuilderTextField(name: 'fullname'),
                                SizedBox(height: 10),
                                FormBuilderTextField(name: 'password'),
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
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Styles.colorBackground,
                                ),
                                child: Text(
                                  'REGISTER',
                                  style: Styles.button_big,
                                )))),
                    Text('Already have an account? Sign in.')
                  ],
                ))));
  }
}
