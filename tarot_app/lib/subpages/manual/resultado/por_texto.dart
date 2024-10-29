import 'package:flutter/material.dart';
import 'package:tarotia/constants_colors.dart';
import 'package:tarotia/models/cartas.dart';

class JustifiedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const JustifiedText({
    required this.text,
    this.fontSize = 18.0,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ocupa toda a largura disponível
      padding:
          const EdgeInsets.symmetric(vertical: 8.0), // Espaçamento vertical
      child: Text(
        text,
        textAlign: TextAlign.justify, // Justifica o texto
        style: TextStyle(fontSize: fontSize, color: color),
      ),
    );
  }
}

class DetalhesCartaScreen extends StatelessWidget {
  final CartaTarot carta;

  const DetalhesCartaScreen({super.key, required this.carta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColors.primary,
        title: Text(
          carta.nome,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Raleway',
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: ConstColors.dark,
      body: ListView(
        padding: const EdgeInsets.all(26.0),
        children: [
          Column(
            children: [
              SizedBox(
                width: 200,
                height: 300,
                child: Image.asset(
                  carta.imagemUrl.isNotEmpty
                      ? carta.imagemUrl
                      : 'assets/img/tarot1.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Nome: ${carta.nome}",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: ConstColors.secondary),
              ),
              SizedBox(height: 20),
            ],
          ),
          Column(
            children: [
              JustifiedText(text: "Tipo: ${carta.tipo}"),
              SizedBox(height: 10),
              JustifiedText(text: "Naipe: ${carta.naipe}"),
              SizedBox(height: 10),
              JustifiedText(text: "Número: ${carta.numero}"),
              SizedBox(height: 10),
              JustifiedText(
                text: "Simbolismo: ${carta.simbolismo.join(', ')}",
              ),
              SizedBox(height: 20),
              JustifiedText(text: "Descrição: ${carta.descricao}"),
              SizedBox(height: 30),
              JustifiedText(text: "Invertido: ${carta.inversao}"),
            ],
          ),
        ],
      ),
    );
  }
}
