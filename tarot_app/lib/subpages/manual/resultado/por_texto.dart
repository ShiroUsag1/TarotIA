import 'package:flutter/material.dart';

class ResultadoCartaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado da Busca'),
      ),
      body: Center(
        child: Text('Aqui será exibido o resultado da carta buscada.'),
      ),
    );
  }
}
