import 'dart:convert'; // Adicione esta importação
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tarot_app/constants_Colors.dart';
import 'package:tarot_app/models/cartas.dart';
import 'package:tarot_app/models/mock_cartas.dart';

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
                  // Verifica se a imagem é uma string base64 ou um caminho para asset
                  carta.imagemUrl.startsWith('data:image/')
                      ? Image.memory(
                          _getImageFromBase64(carta.imagemUrl),
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/img/tarot1.png', // Caminho do placeholder
                              fit: BoxFit.contain,
                            );
                          },
                        )
                      : Image.asset(
                          carta.imagemUrl, // Usa diretamente o caminho do asset
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/img/tarot1.png', // Caminho do placeholder
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
    // Remove o prefixo, se existir
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
