import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/Register/register_screen.dart';
import 'package:frontend_looping_ea/Screens/feed/feed_proyectos.dart';
import 'package:frontend_looping_ea/Services/user_service.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import '../../Models/Project.dart';
import '../../Shared/google_signin_api.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:frontend_looping_ea/Shared/shared_preferences.dart';

//import styles
import 'package:frontend_looping_ea/styles.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _user = User("", "", "", "", "", "");

  bool _remeberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackground,
      body: SingleChildScrollView(
          child: Container(
              height: 600.0,
              margin: const EdgeInsets.all(30),
              //margin: const EdgeInsets.fromLTRB(400.0, 15.0, 400.0, 15.0),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text('Welcome ',
                            style:
                                TextStyle(fontSize: 25.0, color: Colors.black)),
                      ),
                      Container(
                          child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black),
                        child: Text('Develooper.',
                            style:
                                TextStyle(fontSize: 25.0, color: Colors.white)),
                      ))
                    ],
                  ),
                  FormBuilder(
                      key: _formKey,
                      child: SizedBox(
                          child: Column(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                            child: FormBuilderTextField(
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
                                  prefixIcon: Icon(
                                    Icons.people,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)))),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                            child: FormBuilderTextField(
                                name: 'password',
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
                                    hintText: 'Enter your Password',
                                    labelText: "Password",
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.black,
                                    ),
                                    /* suffixIcon: Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                    ),*/
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)))),
                                obscureText: true),
                          ),
                        ],
                      ))),
                  Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () => print('Forgot Password Button Pressed'),
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text('Forgot Password?'),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Theme(
                            data:
                                ThemeData(unselectedWidgetColor: Colors.black),
                            child: Checkbox(
                                value: _remeberMe,
                                checkColor: Colors.green,
                                activeColor: Colors.blue,
                                onChanged: (value) {
                                  setState(() => _remeberMe = !_remeberMe);
                                })),
                        Text(
                          'Remember me',
                        ),
                      ],
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black26,
                            offset: new Offset(8.0, 5.0),
                          ),
                        ],
                      ),
                      child: SizedBox(
                          height: 60,
                          width: 150,
                          child: ElevatedButton(
                              onPressed: _onPressButton,
                              style: ElevatedButton.styleFrom(
                                primary: Styles.colorBackground,
                              ),
                              child: Text(
                                'LOG IN',
                                style: Styles.button_big,
                              )))),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text(
                          '- OR USE -',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => print('Login with Facebook'),
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 6.0,
                                  )
                                ],
                                image: DecorationImage(
                                    image: AssetImage('images/facebook.png'))),
                          ),
                        ),
                        InkWell(
                          onTap: () => signInGoogle(),
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('images/google.png'))),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => print('Login with Apple'),
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('images/apple.png'))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(TextSpan(
                      text: 'Do not have an account yet? ',
                      children: <TextSpan>[
                        TextSpan(
                            text: "Sign up",
                            style: Styles.linkedText,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              })
                      ]))
                ],
              ))),
    );
  }

  void _onPressButton() async {
    final validator = _formKey.currentState!.validate();

    if (validator) {
      // SAVE THE STATE OF THE FORM
      _formKey.currentState!.save();

      // GRAB THE FIELDS
      _user.uname = _formKey.currentState!.fields['username']!.value;
      _user.pswrd = _formKey.currentState!.fields['password']!.value;

      // http?
      try {
        print("preparing _user $_user");
        await loginUser(_user).then((value) async {
          print(value);
          if (value.uname != "") {
            print("seting ${value.uname} to shared preferences.");
            await setUsernameToSharedPref(value.uname);

            print("pushing to next view.");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FeedProyectos(user: value)));
          } else {}
        });
      } catch (err) {
        print(err);
      }
    } else {}
  }

  Future signInGoogle() async {
    GoogleSignInAccount userGoogle = await GoogleSignInApi.login();
    if (userGoogle == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign in Failed')));
    } else {
      User user = new User(userGoogle.displayName.toString(), "",
          userGoogle.displayName.toString(), userGoogle.email, "", "");
      try {
        await loginUser(user).then((value) async {
          if (value.uname != "") {
            await setUsernameToSharedPref(value.uname);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FeedProyectos(user: value)));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Are you registered?')));
          }
        });
      } catch (err) {
        print(err);
      }
    }
  }
}
