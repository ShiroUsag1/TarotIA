import 'package:flutter/material.dart';
import 'constants_colors.dart';
import 'package:tarotia/subpages/ajudaia/ajuda_ia.dart';
import 'package:tarotia/subpages/manual/manual.dart';
// ignore: unused_import
import 'dart:math' as math;

import 'subpages/tiragem/tiragem.dart';

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
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -10.0, end: 10.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildTarotCard(
      String title, String imagePath, bool moveOpposite, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset:
                Offset(moveOpposite ? -_animation.value : _animation.value, 0),
            child: Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white, width: 3),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColors.primary,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Tarot',
                style: TextStyle(
                  fontFamily: 'AlexBrush',
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: 'IA',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: ConstColors.dark,
            image: DecorationImage(
              image: AssetImage('assets/img/bg1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                _buildTarotCard(
                    "Tiragem Aleatória", 'assets/img/tarot1.png', false, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TiragemScreen()),
                  );
                }),
                SizedBox(height: 20),
                _buildTarotCard("Ajuda da IA", 'assets/img/tarot2.png', true,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AjudaIAScreen()),
                  );
                }),
                SizedBox(height: 20),
                _buildTarotCard(
                    "Manual Das Cartas", 'assets/img/tarot3.png', false, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManualCartasScreen()),
                  );
                }),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
