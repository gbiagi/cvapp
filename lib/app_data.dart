import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppData with ChangeNotifier {
  final String url = 'http://localhost:11434/api/generate';
  String promptStart =
      'Estic preparant un cv. Tradueix i formata aquest text de manera formal en angles. Respon nomes amb el text traduit i formatat.: ';

  Future<String> sendToOllama(String field, String data) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'model': 'llama3.2:3b',
        "stream": false,
        'prompt': '$promptStart $data'
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['response'];
    } else {
      throw Exception('Error en correcció');
    }
  }
}
