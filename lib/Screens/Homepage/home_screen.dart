import 'package:flutter/material.dart';

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
              style: Styles.title,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Text(
              "This is the best platform to find new projects to work on. You can also find new teammates to work with in your next amazing project. ",
              style: Styles.subtitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 100),
            Container(
                margin: EdgeInsets.fromLTRB(
                    0, size.width * 0.25, 0, size.width * 0.05),
                width: size.width * 0.7,
                height: size.width * 0.1,
                child: TextButton(
                    style: Styles.flatButtonStyle,
                    onPressed: () {},
                    child: Text(
                      "Sign in",
                      style: Styles.subtitle,
                    ))),
            Container(
                width: size.width * 0.7,
                height: size.width * 0.1,
                child: TextButton(
                    style: Styles.flatButtonStyle,
                    onPressed: () {},
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
