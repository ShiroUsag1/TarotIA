import 'package:flutter/material.dart';
import 'intro_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Raleway'),
          bodyLarge: TextStyle(fontFamily: 'Roboto'),
        ),
      ),
      home: IntroMain(),
    );
  }
}
