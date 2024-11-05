import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tarotia/models/cartas.dart';
import 'package:tarotia/models/mock_cartas.dart';

class TiragemScreen extends StatefulWidget {
  @override
  TiragemScreenState createState() => TiragemScreenState();
}

class TiragemScreenState extends State<TiragemScreen>
    with SingleTickerProviderStateMixin {
  List<CartaTarot> cartasSelecionadas = [];
  bool mostrarVerso = true;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 4.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 4.0, end: 5.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 5.0, end: 5.5), weight: 30),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  void _tirarCartas() {
    final random = Random();
    cartasSelecionadas = List.generate(
      3,
      (_) => mockCartas[random.nextInt(mockCartas.length)],
    );

    setState(() {
      mostrarVerso = true;
    });
    _controller.forward(from: 0);

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        mostrarVerso = false;
      });
      _controller.forward(from: 0.025);
      _controller.animateBack(0.0, duration: Duration(seconds: 2));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tiragem de Tarot")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              final carta = cartasSelecionadas.isNotEmpty
                  ? cartasSelecionadas[index]
                  : null;

              return Transform(
                transform: Matrix4.rotationY(_animation.value * 3.1416),
                alignment: Alignment.center,
                child: Card(
                  child: SizedBox(
                    width: 100,
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(mostrarVerso
                            ? "assets/cards/back.jpg"
                            : carta!.imagemUrl)
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _tirarCartas,
            child: Text("Tirar Cartas"),
          ),
        ],
      ),
    );
  }
}
