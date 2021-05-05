import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/Register/register_screen.dart';

//import styles
import 'package:frontend_looping_ea/styles.dart';

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _user = User("", "", "", "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackground,
      body: Column(
        children: [
          FormBuilder(
            key: _formKey,
            child: FormBuilderTextField(name: 'username'),
          ),
        ],
      ),
    );
  }
}
