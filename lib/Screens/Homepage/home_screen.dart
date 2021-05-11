import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'package:frontend_looping_ea/Screens/Login/login_page.dart';
import 'package:frontend_looping_ea/Screens/Register/register_screen.dart';
import 'package:frontend_looping_ea/Screens/feed/feed_proyectos.dart';

import '../../styles.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Styles.colorBackground,
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOOPING",
              style: Styles.titleSplash,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.075),
            Text(
              "This is the best platform to find new projects to work on. You can also find new teammates to work with in your next amazing project. ",
              style: Styles.subtitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.15),
            Container(
                margin: EdgeInsets.fromLTRB(
                    0, size.height * 0.08, 0, size.height * 0.04),
                width: size.width * 0.7,
                height: size.width * 0.05,
                child: TextButton(
                    style: Styles.flatButtonStyle,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "Sign in",
                      style: Styles.subtitle,
                    ))),
            Container(
                width: size.width * 0.7,
                height: size.width * 0.05,
                child: TextButton(
                    style: Styles.flatButtonStyle,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: Text(
                      "Sign up",
                      style: Styles.subtitle,
                    )))
          ],
        ),
      ),
    );
  }
}
