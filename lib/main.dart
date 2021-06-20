import 'package:flutter/material.dart';
import 'Screens/Splash/splash_screen.dart';
import 'environment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Environment _environment = Environment();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    this._environment.mode = "DEV";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
