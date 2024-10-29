import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tarotia/models/cartas.dart';

class ApiService {
  Future<List<CartaTarot>> fetchCartas() async {
    await dotenv.load(fileName: ".env");
    String? url = dotenv.env['BACKEND_URL'];

    final response = await http.get(Uri.parse(url!));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => CartaTarot.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar cartas');
    }
  }
}
