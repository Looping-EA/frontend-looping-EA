import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Screens/Homepage/home_screen.dart';
import 'package:frontend_looping_ea/styles.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(milliseconds: 2500),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              "A very serious business",
              style: Styles.subtitle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
