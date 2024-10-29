import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tarotia/models/mock_cartas.dart';
import '../../constants_colors.dart';
import 'resultado/por_imagem.dart';
import 'resultado/por_texto.dart';
import '../../models/cartas.dart';

class ManualCartasScreen extends StatefulWidget {
  @override
  ManualCartasScreenState createState() => ManualCartasScreenState();
}

class ManualCartasScreenState extends State<ManualCartasScreen> {
  List<CartaTarot> cartas = [];
  final TextEditingController searchController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _carregarCartas();
  }

  void _carregarCartas() {
    cartas = mockCartas;
  }

  void _pesquisarCarta() async {
    final nome = searchController.text.trim();

    if (nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, insira um nome')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 1));

    final cartaEncontrada = cartas.firstWhereOrNull(
      (carta) => carta.nome.toLowerCase().contains(nome.toLowerCase()),
    );

    setState(() {
      _isLoading = false;
    });

    if (cartaEncontrada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nenhuma carta encontrada')),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetalhesCartaScreen(carta: cartaEncontrada),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ConstColors.primary,
              image: DecorationImage(
                image: AssetImage('assets/img/bg1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            )
          else
            ListView(
              children: [
                AppBar(
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
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Column(
                    children: [
                      Text(
                        "Quer aprender mais sobre cartas de TAROT?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      Text(
                        "Procure aqui os significados de cada uma e muito mais através do nome ou da imagem da carta.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 80),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Insira o nome da carta',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _pesquisarCarta,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Icon(
                              Icons.search,
                              size: 32.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BuscaImagemScreen()),
                          );
                        },
                        icon: Icon(Icons.remove_red_eye),
                        label: Text(
                          'Procure por Imagem',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 180),
                      Text(
                        "Atenção! Ao procurar por nome favor inserir os números por extenso.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
