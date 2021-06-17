import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/Login/login_page.dart';
import 'package:frontend_looping_ea/Screens/Profile/profile_screen.dart';
import 'package:frontend_looping_ea/Screens/Register/register_screen.dart';
import 'package:frontend_looping_ea/Screens/feed/feed_proyectos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend_looping_ea/Services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Shared/google_signin_api.dart';

//import styles
import 'package:frontend_looping_ea/styles.dart';

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _user = User("", "", "", "", "", "", [], []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.colorBackground,
        body: Center(
            child: Container(
                margin: const EdgeInsets.all(30),
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
                                      image:
                                          AssetImage('images/facebook.png'))),
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
                        text: 'Already have an account? ',
                        children: <TextSpan>[
                          TextSpan(
                              text: "Sign in.",
                              style: Styles.linkedText,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                })
                        ]))
                  ],
                ))));
  }

  void _onPressButton() async {
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
      try {
        await registerUser(_user).then((value) async {
          await setUsernameToSharedPref(value.uname);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FeedProyectos(user: value)));
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
          userGoogle.displayName.toString(), userGoogle.email, "", "", [], []);
      try {
        await registerUser(user).then((value) async {
          if (value.uname != "") {
            await setUsernameToSharedPref(value.uname);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FeedProyectos(user: value)));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Are you already registered? Try loging in')));
          }
        });
      } catch (err) {
        print(err);
      }
    }
  }
}
