import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/photo.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/Login/login_page.dart';
import 'package:frontend_looping_ea/Screens/Register/register_screen.dart';
import 'package:frontend_looping_ea/Screens/feed/feed_proyectos.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:frontend_looping_ea/Services/user_service.dart';
import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import '../../Shared/google_signin_api.dart';

//import styles
import 'package:frontend_looping_ea/styles.dart';

class RegisterScreenState extends State<RegisterScreen> {
  final _user = User("", "", "", "", "", "", [], [], [], "");

  final _formKey = GlobalKey<FormState>();

  UserService userService = new UserService();

  TextEditingController unameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController fullNameEditingController = TextEditingController();

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
                    Form(
                        key: _formKey,
                        child: SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: unameEditingController,
                                  validator: (value) {
                                    if (value!.contains(" ")) {
                                      return 'may not contain spaces';
                                    }
                                    if (value.length < 5) {
                                      return 'your username must be 5 characters long';
                                    }
                                    if (value.isEmpty) {
                                      return 'value cannot be null';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Enter your Username',
                                      labelText: "Username",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)))),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: emailEditingController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "field must not be empty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Enter your Email',
                                      labelText: "Email",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)))),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: fullNameEditingController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "field must not be empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Enter your Full Name',
                                      labelText: "Full Name",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)))),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                    controller: passwordEditingController,
                                    validator: (value) {
                                      if (value!.contains(" ")) {
                                        return "field must not contain whitespaces";
                                      }
                                      if (value.length < 5) {
                                        return "Minimum length requirement must be 5 characters long.";
                                      }
                                      if (value.isEmpty) {
                                        return "field must not be empty";
                                      }
                                      return null;
                                    },
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
      _user.uname = unameEditingController.text;
      _user.email = emailEditingController.text;
      _user.pswrd = passwordEditingController.text;
      _user.fullname = fullNameEditingController.text;

      // http?
      try {
        await userService.registerUser(_user).then((value) async {
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
    } else {}
  }

  Future signInGoogle() async {
    GoogleSignInAccount userGoogle = await GoogleSignInApi.login();
    if (userGoogle == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign in Failed')));
    } else {
      Photo p = new Photo("");
      User user = new User(
          userGoogle.displayName.toString(),
          "",
          userGoogle.displayName.toString(),
          userGoogle.email,
          "",
          "",
          [],
          [],
          [],
          "");
      try {
        await userService.registerUser(user).then((value) async {
          print(value.uname + " chikilicuatre");
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
