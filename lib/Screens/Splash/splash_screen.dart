import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Screens/Login/Login_screen.dart';
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
              MaterialPageRoute(builder: (context) => LoginScreen()),
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

  //Para acceder al Perfil
  // void _navigationToPerfil(BuildContext context) {
  //  Navigator.push(context,
  //      MaterialPageRoute(builder: (context) => Register()));
  //}
}
