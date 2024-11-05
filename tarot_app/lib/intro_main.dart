import 'package:flutter/material.dart';
import 'constants_colors.dart';
import 'dashboard_screen.dart';

class IntroMain extends StatefulWidget {
  @override
  IntroMainState createState() => IntroMainState();
}

class IntroMainState extends State<IntroMain> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo ao',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.normal,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Tarot',
                    style: TextStyle(
                      fontFamily: 'AlexBrush',
                      fontSize: 100,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: 'IA',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Explore suas cartas!',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.normal,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(
              strokeWidth: 4.0,
              valueColor:
                  AlwaysStoppedAnimation<Color>(const Color(0xFFFFFFFF)),
            ),
          ],
        ),
      ),
    );
  }
}
