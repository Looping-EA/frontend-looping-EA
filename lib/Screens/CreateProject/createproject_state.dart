import 'package:frontend_looping_ea/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateProjectState extends State<CreateProjectScreen> {
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
                        key: _formKey,
                        child: SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                FormBuilderTextField(
                                  name: 'username',
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.minLength(context, 5),
                                    (value) {
                                      if (value!.contains(" ")) {
                                        return 'may not contain spaces';
                                      } else {
                                        return null;
                                      }
                                    }
                                  ]),
                                  decoration: InputDecoration(
                                      hintText: 'Enter your Username',
                                      labelText: "Username",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)))),
                                ),
                                SizedBox(height: 20),
                                FormBuilderTextField(
                                  name: 'email',
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.email(context),
                                    FormBuilderValidators.required(context)
                                  ]),
                                  decoration: InputDecoration(
                                      hintText: 'Enter your Email',
                                      labelText: "Email",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)))),
                                ),
                                SizedBox(height: 20),
                                FormBuilderTextField(
                                  name: 'fullname',
                                  validator:
                                      FormBuilderValidators.required(context),
                                  decoration: InputDecoration(
                                      hintText: 'Enter your Full Name',
                                      labelText: "Full Name",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)))),
                                ),
                                SizedBox(height: 20),
                                FormBuilderTextField(
                                    name: 'password',
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                      FormBuilderValidators.minLength(
                                          context, 5),
                                      (value) {
                                        if (value!.contains(" ")) {
                                          return 'may not contain spaces';
                                        } else {
                                          return null;
                                        }
                                      }
                                    ]),
                                    decoration: InputDecoration(
                                        hintText: 'Enter your Password',
                                        labelText: "Password",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)))),
                                    obscureText: true),
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
                                  'REGISTER',
                                  style: Styles.button_big,
                                )))),
                    Text.rich(TextSpan(
                        text: 'Already have an account? ',
                        children: <TextSpan>[
                          TextSpan(text: "Sign in.", style: Styles.linkedText)
                        ]))
                  ],
                ))));
  }

  void _onPressButton() {
    final validator = _formKey.currentState!.validate();

    if (validator) {
      // SAVE THE STATE OF THE FORM
      _formKey.currentState!.save();

      // GRAB THE FIELDS
      _user.uname = _formKey.currentState!.fields['username']!.value;
      _user.email = _formKey.currentState!.fields['email']!.value;
      _user.pswrd = _formKey.currentState!.fields['password']!.value;
      _user.fullname = _formKey.currentState!.fields['fullname']!.value;

      // http?
      var user = new User("", "", "", "");
      _registerUser().then((value) => user = value);
      print(user);
    } else {}
  }

  Future<User> _registerUser() async {
    User user = new User("", "", "", "");

    // create JSON object
    final body = {
      "uname": _user.uname,
      "pswd": _user.pswrd,
      "email": _user.email,
      "fullname": _user.fullname
    };
    final bodyParsed = json.encode(body);

    // finally the POST HTTP operation
    return await http
        .post(Uri.parse("http://localhost:8080/api/users/register"),
            headers: <String, String>{'Content-Type': 'application/json'},
            body: bodyParsed)
        .then((http.Response response) {
      if (response.statusCode == 201) {
        return User.fromJson(json.decode(response.body));
      } else {
        return new User("", "", "", "");
      }
    });
  }
}
