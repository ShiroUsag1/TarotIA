import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tarotia/constants_Colors.dart';
import 'package:tarotia/models/cartas.dart';
import 'package:tarotia/models/mock_cartas.dart';

class BuscaImagemScreen extends StatefulWidget {
  @override
  BuscaImagemScreenState createState() => BuscaImagemScreenState();
}

class BuscaImagemScreenState extends State<BuscaImagemScreen> {
  late List<CartaTarot> cartas;

  @override
  void initState() {
    super.initState();
    cartas = mockCartas;
  }

  void _showCartaDialog(CartaTarot carta) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 400,
            decoration: BoxDecoration(
              color: const Color.fromARGB(0, 0, 0, 0),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  carta.imagemUrl.startsWith('data:image/')
                      ? Image.memory(
                          _getImageFromBase64(carta.imagemUrl),
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/img/tarot1.png',
                              fit: BoxFit.contain,
                            );
                          },
                        )
                      : Image.asset(
                          carta.imagemUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/img/tarot1.png',
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      carta.nome,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Text(
                      "Descrição: ${carta.descricao} \n\n"
                      "Inversâo:${carta.inversao} \n\n"
                      "Tipo: ${carta.tipo} \n\n"
                      "Naipe ou Elemento: ${carta.naipe} \n\n"
                      "Número: ${carta.numero} \n\n"
                      "Simbolismo: ${carta.simbolismo.join(', ')}",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "Fechar",
                      style: TextStyle(color: ConstColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Uint8List _getImageFromBase64(String base64String) {
    if (base64String.startsWith('data:image')) {
      base64String = base64String.split(',').last;
    }

    return base64Decode(base64String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Manual das Cartas',
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
      backgroundColor: ConstColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 0.6,
          ),
          itemCount: cartas.length,
          itemBuilder: (context, index) {
            final carta = cartas[index];
            return GestureDetector(
              onTap: () {
                _showCartaDialog(carta);
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(carta.imagemUrl),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
