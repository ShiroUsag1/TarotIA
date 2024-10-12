import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ButtonWidget extends StatefulWidget {
  @override
  ButtonWidgetState createState() => ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget> {
  String apiResponse = "Esperando resposta...";

  Future<void> fetchApiData() async {
    await dotenv.load(fileName: ".env");
    String? backendUrl = dotenv.env['BACKEND_URL']; // URL do seu backend

    try {
      final response = await http.post(
        Uri.parse(backendUrl!),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "cartas": [
            "O Louco",
            "A Morte",
            "A Torre"
          ] // Cartas selecionadas no app
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          apiResponse = data['interpretacao']; // Mostra a interpretação no app
        });
      } else {
        setState(() {
          apiResponse = 'Erro: ${response.statusCode} - ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        apiResponse = 'Erro de conexão: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(apiResponse),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: fetchApiData,
          child: Text("Fazer Chamada API"),
        ),
      ],
    );
  }
}
