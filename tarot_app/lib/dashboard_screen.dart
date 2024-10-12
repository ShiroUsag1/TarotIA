import 'package:flutter/material.dart';
// ignore: unused_import
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    // Rotação entre -25 graus (-0.436 radianos) e 25 graus (0.436 radianos)
    _animation = Tween<double>(begin: -0.436, end: 0.436).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1B), // Fundo da dashboard
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50), // Espaçamento inicial opcional
              _buildTarotCard("Tiragem Aleatória", 'assets/img/tarot1.png'),
              SizedBox(height: 20),
              _buildTarotCard("Ajuda da IA", 'assets/img/tarot2.png'),
              SizedBox(height: 20),
              _buildTarotCard("Manual Das Cartas", 'assets/img/tarot3.png'),
              SizedBox(height: 50), // Espaçamento final opcional
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTarotCard(String title, String imagePath) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(_animation.value), // Rotaciona no eixo Y
          child: Container(
            width: 200, // Formato de carta de tarot (retangular)
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    imagePath), // Usa o caminho da imagem passado como parâmetro
                fit: BoxFit.cover, // Ajusta a imagem para cobrir o container
              ),
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: Colors.white, width: 3), // Bordas brancas
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
