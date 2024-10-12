import 'package:flutter/material.dart';
import 'intro_main.dart'; // Importa a tela de introdução

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroMain(), // Chama a tela de introdução
    );
  }
}
